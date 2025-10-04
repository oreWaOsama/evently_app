import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/theming/assets_manager.dart';
import 'package:evently_app/core/theming/colors_manager.dart';
import 'package:evently_app/core/theming/text_styles.dart';
import 'package:evently_app/core/utils/toast_utils.dart';
import 'package:evently_app/core/widgets/custom_elevated_buttom.dart';
import 'package:evently_app/core/widgets/custom_text_form_field.dart';
import 'package:evently_app/core/widgets/event_date_or_time.dart';
import 'package:evently_app/feature/home/taps/home_tab/widgets/events_tabs_item.dart';
import 'package:evently_app/firebase_utils.dart';
import 'package:evently_app/model/event.dart';
import 'package:evently_app/providers/event_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateEvent extends StatefulWidget {
  static const String routeName = '/create_event';
  const CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  int selectedIndex = 0;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String? formatTime;
  String selectedEventName = '';
  String selectedEventImage = '';
  late EventListProvider eventListProvider;

  var formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    eventListProvider = Provider.of<EventListProvider>(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    List<String> eventsName = [
      tr('sport'),
      tr('birthday'),
      tr('meeting'),
      tr('gaming'),
      tr('workshop'),
      tr('book_club'),
      tr('exhibition'),
      tr('holiday'),
      tr('eating'),
    ];

    List<String> eventsImages = [
      AssetsManager.sportImage,
      AssetsManager.birthdayImage,
      AssetsManager.meetingImage,
      AssetsManager.gamingImage,
      AssetsManager.workshopImage,
      AssetsManager.bookClubImage,
      AssetsManager.exhibitionImage,
      AssetsManager.holidayImage,
      AssetsManager.eatingImage,
    ];

    selectedEventImage = eventsImages[selectedIndex];
    selectedEventName = eventsName[selectedIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(tr('create_event'), style: TextStyles.medium20Primary),

        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(eventsImages[selectedIndex]),
              ),
              SizedBox(height: height * 0.02),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height * 0.04,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: EventsTabsItem(
                              borderColor: ColorsManager.primaryLight,
                              selectedTextStyle: TextStyles.medium16White,
                              unselectedTextStyle: Theme.of(
                                context,
                              ).textTheme.headlineSmall!,
                              selectedBackgroundColor:
                                  ColorsManager.primaryLight,
                              eventName: eventsName[index],
                              isSelected: selectedIndex == index,
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(width: width * 0.02),
                        itemCount: eventsName.length,
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    Text(tr('title'), style: TextStyles.medium16Black),
                    SizedBox(height: height * 0.01),
                    CustomTextFormField(
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return tr('please_enter_event_title');
                        }
                        return null;
                      },
                      controller: titleController,
                      hintText: tr('event_title'),
                      prefixIcon: Image.asset(AssetsManager.iconEdit),
                    ),
                    SizedBox(height: height * 0.02),
                    Text(tr('description'), style: TextStyles.medium16Black),
                    SizedBox(height: height * 0.01),
                    CustomTextFormField(
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return tr('please_enter_event_description');
                        }
                        return null;
                      },
                      controller: descriptionController,
                      hintText: tr('event_description'),
                      maxLines: 4,
                    ),
                    SizedBox(height: height * 0.001),
                    EventDateOrTime(
                      iconDateOrTime: AssetsManager.iconDate,
                      eventDateorTime: tr('event_date'),
                      textButton: selectedDate == null
                          ? tr('choose_date')
                          : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                      onPressed: chooseDate,
                    ),
                    SizedBox(height: height * 0.0001),
                    EventDateOrTime(
                      iconDateOrTime: AssetsManager.iconTime,
                      eventDateorTime: tr('event_time'),
                      textButton: selectedTime == null
                          ? tr('choose_time')
                          : selectedTime!.format(context),
                      onPressed: chooseTime,
                    ),
                    SizedBox(height: height * 0.02),
                    Text(tr('location'), style: TextStyles.medium16Black),
                    SizedBox(height: height * 0.01),
                    Container(
                      width: width,
                      height: height * 0.06,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: ColorsManager.primaryLight,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: width * 0.11,
                            height: height * 0.06,
                            decoration: BoxDecoration(
                              color: ColorsManager.primaryLight,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: IconButton(
                              onPressed: () {},
                              icon: ImageIcon(
                                AssetImage(AssetsManager.iconLocation),
                                color: ColorsManager.whiteColor,
                              ),
                            ),
                          ),
                          SizedBox(width: width * 0.02),

                          Text(
                            tr('choose_location'),
                            style: TextStyles.medium16Primary,
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: ColorsManager.primaryLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    CustomElevatedButtom(
                      onPressed: addEvent,
                      text: tr('create_event'),
                    ),

                    SizedBox(height: height * 0.02),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addEvent() {
    if (formKey.currentState?.validate() == true) {
      Event event = Event(
        image: selectedEventImage,
        title: titleController.text,
        description: descriptionController.text,
        eventName: selectedEventName,
        dateTime: selectedDate!,
        time: formatTime!,
      );
      FirebaseUtils.addEventToFirestore(event).timeout(
        Duration(milliseconds: 500),
        onTimeout: () {
          ToastUtils.toastMsg(
            backgroundColor: ColorsManager.primaryLight,
            textColor: ColorsManager.whiteColor,
            message: tr('event_added_successfully'),
          );
          eventListProvider.getAllEvents();
          Navigator.pop(context);
        },
      );
    }
  }

  void chooseDate() async {
    var chooseDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    selectedDate = chooseDate;
    setState(() {});
  }

  void chooseTime() async {
    var chooseTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    selectedTime = chooseTime;
    formatTime = selectedTime!.format(context);
    setState(() {});
  }
}
