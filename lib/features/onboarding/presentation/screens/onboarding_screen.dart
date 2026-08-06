import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medibook/app/app_colors.dart';
import 'package:medibook/app/app_text_styles.dart';
import '../../../../app/routes/app_routes.dart';
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() =>
      _OnboardingScreenState();
}
class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentIndex = 0;
  final List<Map<String, String>> pages = [
    {
      "title": "Find The Best Doctors",
      "description":
      "Search for doctors based on specialty and location easily.",
    },
    {
      "title": "Book Appointments Easily",
      "description":
      "Choose your preferred time and reserve your appointment.",
    },
    {
      "title": "Manage Your Health",
      "description":
      "Keep track of your appointments anytime anywhere.",
    },
  ];
  void nextPage() {
    if(currentIndex == pages.length - 1){
      context.go(AppRoutes.login);
    }else{
      _controller.nextPage(
        duration:
        const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
          const EdgeInsets.all(24),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: pages.length,
                  onPageChanged: (index){
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemBuilder: (context,index){
                    return Column(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 220,
                          width: 220,
                          decoration:
                          BoxDecoration(
                            color:
                            AppColors.primary
                                .withOpacity(.1),
                            shape:
                            BoxShape.circle,
                          ),
                          child:
                          const Icon(
                            Icons
                                .medical_services,
                            size: 100,
                            color:
                            AppColors.primary,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Text(
                          pages[index]["title"]!,
                          textAlign:
                          TextAlign.center,
                          style:
                          AppTextStyles.heading2,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          pages[index]
                          ["description"]!,
                          textAlign:
                          TextAlign.center,
                          style:
                          AppTextStyles.body,
                        ),
                      ],
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment:
                MainAxisAlignment.center,
                children: List.generate(
                  pages.length,
                      (index)=>AnimatedContainer(
                    duration:
                    const Duration(
                        milliseconds:300),
                    margin:
                    const EdgeInsets.all(4),
                    height: 8,
                    width:
                    currentIndex == index
                        ? 30
                        : 8,
                    decoration:
                    BoxDecoration(
                      color:
                      currentIndex == index
                          ? AppColors.primary
                          : AppColors.lightGrey,
                      borderRadius:
                      BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height:30),
              ElevatedButton(
                onPressed: nextPage,
                child:
                Text(
                  currentIndex ==
                      pages.length -1
                      ? "Get Started"
                      : "Next",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}