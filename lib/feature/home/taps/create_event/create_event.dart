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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateEvent extends StatefulWidget {
  static const String routeName = '/create_event';
  const CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  int selectedIndex = 0;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String? formattedTime;

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final eventsName = <String>[
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

    final eventsImages = <String>[
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

    final selectedEventName = eventsName[selectedIndex];
    final selectedEventImage = eventsImages[selectedIndex];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(tr('create_event'), style: TextStyles.medium20Primary),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(selectedEventImage),
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
                        itemCount: eventsName.length,
                        separatorBuilder: (_, __) =>
                            SizedBox(width: width * 0.02),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () => setState(() => selectedIndex = index),
                            child: EventsTabsItem(
                              eventName: eventsName[index],
                              isSelected: selectedIndex == index,
                              borderColor: ColorsManager.primaryLight,
                              selectedBackgroundColor:
                                  ColorsManager.primaryLight,
                              selectedTextStyle: TextStyles.medium16White,
                              unselectedTextStyle: Theme.of(
                                context,
                              ).textTheme.headlineSmall!,
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: height * 0.02),

                    Text(tr('title'), style: TextStyles.medium16Black),
                    SizedBox(height: height * 0.01),
                    CustomTextFormField(
                      controller: titleController,
                      hintText: tr('event_title'),
                      prefixIcon: Image.asset(AssetsManager.iconEdit),
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return tr('please_enter_event_title');
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: height * 0.02),
                    Text(tr('description'), style: TextStyles.medium16Black),
                    SizedBox(height: height * 0.01),
                    CustomTextFormField(
                      controller: descriptionController,
                      hintText: tr('event_description'),
                      maxLines: 4,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return tr('please_enter_event_description');
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: height * 0.001),
                    EventDateOrTime(
                      iconDateOrTime: AssetsManager.iconDate,
                      eventDateorTime: tr('event_date'),
                      textButton: selectedDate == null
                          ? tr('choose_date')
                          : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                      onPressed: _chooseDate,
                    ),
                    SizedBox(height: height * 0.0001),
                    EventDateOrTime(
                      iconDateOrTime: AssetsManager.iconTime,
                      eventDateorTime: tr('event_time'),
                      textButton: selectedTime == null
                          ? tr('choose_time')
                          : formattedTime ?? tr('choose_time'),
                      onPressed: _chooseTime,
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
                          const Spacer(),
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
                      onPressed: () => _addEvent(
                        selectedEventImage: selectedEventImage,
                        selectedEventName: selectedEventName,
                      ),
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

  Future<void> _addEvent({
    required String selectedEventImage,
    required String selectedEventName,
  }) async {
    if (formKey.currentState?.validate() != true) return;

    if (selectedDate == null) {
      ToastUtils.toastMsg(
        backgroundColor: ColorsManager.primaryLight,
        textColor: ColorsManager.whiteColor,
        message: tr('please_choose_date'),
      );
      return;
    }
    if (selectedTime == null || formattedTime == null) {
      ToastUtils.toastMsg(
        backgroundColor: ColorsManager.primaryLight,
        textColor: ColorsManager.whiteColor,
        message: tr('please_choose_time'),
      );
      return;
    }

     
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null || uid.isEmpty) {
      ToastUtils.toastMsg(
        backgroundColor: Colors.red,
        textColor: Colors.white,
        message: 'User not signed in.',
      );
      return;
    }

    final event = Event(
      image: selectedEventImage,
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
      eventName: selectedEventName,
      dateTime: selectedDate!,
      time: formattedTime!,
    );

    try {
      await FirebaseUtils.addEventToFirestore(event, uid);

      ToastUtils.toastMsg(
        backgroundColor: ColorsManager.primaryLight,
        textColor: ColorsManager.whiteColor,
        message: tr('event_added_successfully'),
      );

      context.read<EventListProvider>().getAllEvents(uid);
      if (!mounted) return;
      Navigator.pop(context);
    } catch (e) {
      ToastUtils.toastMsg(
        backgroundColor: Colors.red,
        textColor: Colors.white,
        message: 'Firestore error: $e',
      );
    }
  }

  Future<void> _chooseDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  Future<void> _chooseTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
        formattedTime = picked.format(context);
      });
    }
  }
}
