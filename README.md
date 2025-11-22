# Introduction
This app was created from a problem that me and my friends always have: where to go eat.
We have a certain cuisine or food we'd want, but never could decide on a specific restaurant. So I made this app to solve this problem.

# The App
## The Icon
This is the App Icon used:

<img width="200" height="200" alt="initial_icon" src="https://github.com/user-attachments/assets/9881dea2-dd1b-4f1a-8e13-5a76388a159c" />

## The IntroView
This is the Introduction View:

<img width="300" height="650" alt="simulator_screenshot_27683D20-9681-4DDC-B09F-1A4893605CF0" src="https://github.com/user-attachments/assets/6b7f3d0e-9a2d-493a-9425-115d87e43273" />

This view has a fade away effect that will go into one of the two views.

## The NameView
This is the NameView:

<img width="300" height="650" alt="simulator_screenshot_A55029E9-7244-4AEE-AE80-CF39A5366CD8" src="https://github.com/user-attachments/assets/4a6e6e50-1256-46e1-a7c7-fcc3f92d2f46" />

This view shows up the **first time** the app has been downloaded (or if you delete the app and redownload it). It will ask you to input your name and will be used whenever you use the app. This will be stored in the AppStorage.

## The InputView
This is the InputView:

<img width="300" height="650" alt="simulator_screenshot_3A7049DD-A79F-46EC-A9E8-DE4859483824" src="https://github.com/user-attachments/assets/0690e7e8-536c-433c-9df0-4341a9f49857" />

This is the view that appears after you enter your name in NameView (if you downloaded the app for the first time) or the IntroView. In this view, you can enter the cuisine or food you're interested in, provide a location (address), and select the search radius to limit how far the restaurant can be.

Here is an example of the usage:

<img width="300" height="650" alt="Simulator Screenshot - iPhone 17 Pro - 2025-11-22 at 00 40 31" src="https://github.com/user-attachments/assets/e4730291-37e4-49fd-89f2-0d5c1d5a0508" />

Additionally, there is an autocomplete suggestion for the addresses:

<img width="300" height="650" alt="simulator_screenshot_B4650E1D-6F2E-413C-8E1C-06DCC0229169" src="https://github.com/user-attachments/assets/4f1f7ace-52c3-4a09-86b6-f3924d485386" />

Once you the information is inputted, press "Go!".

Note that if any of the TextFields are empty, it will show an alert telling it is empty, and if there are no results, then it will give an alert. 

## The LoadingView
This is the LoadingView:

<img width="300" height="650" alt="simulator_screenshot_40D58032-C0B0-4911-B402-4633DAA614F4" src="https://github.com/user-attachments/assets/a94893c7-4c77-43f3-9ad6-da0169d8f84f" />

This is the view shown when loading (It is when we are searching for restaurants using MapKit and randomly selecting a restaurant from the list of multiple restaurants, if they exist).

## The SelectedView
This is the SelectedView, and example of when it chooses a restaurant:

<img width="300" height="650" alt="simulator_screenshot_26F9BE12-DAF1-47FB-A39C-96DE6DA8B7BA" src="https://github.com/user-attachments/assets/80ed590d-3402-41f4-8f2e-639b26eb642b" />

This view shows the information of the restaurant. The information includes the name of the restaurant, the address, the phone number, and the website if they have one. It also shows a map of where the restaurant is located, and when tapped, will bring you to the Apple Maps app giving you the direction from your current location.

You can also share the restaurant using the Share Button on the right upper corner!

<img width="300" height="650"  alt="simulator_screenshot_F3E74477-6315-4824-9615-F65A6E3ECF0B" src="https://github.com/user-attachments/assets/df3d676d-5edc-4d7f-bb10-4eef98094adb" />

## Overall
Overall, I was able to learn one of the biggest packages in iOS Development, `MapKit`. It was quite challenging, as I was also fighting the fact that there were some deprecations in the MapKit framework as I was working on this project when iOS 26 update just occurred. Despite some of the challenges, some native iOS frameworks like `MapKit` is very powerful, which was very surprising. I really enjoyed this project as it was related to one of my favorite things in the world, being food, and that I was able to develop an app during a major iOS update, which I believe many companies and developers likely face when they have an iOS application as part of their product.
