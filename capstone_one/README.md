<div align="center">
  <img src="https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a59cd1cf16282.png" alt="Flutter" width="60" />
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/user-attachments/assets/43384b67-8e0e-430b-b888-f19c70f0ad06" alt="Pharmate Logo" width="60" style="border-radius: 12px; object-fit: cover; height: 60px; object-position: top center;"/>
  
  <h1>💊 Pharmate</h1>
  <p><strong>Your Personal Medicine Tracker & Pill Inventory Manager</strong></p>
  <p>Built with Flutter, featuring OpenFDA API integration for comprehensive medicine guides.</p>
  <br />
</div>

## 📖 About The Project

**Pharmate** is a comprehensive mobile application designed to help users track their daily medications, manage pill inventory, and access detailed, reliable medicine information. By leveraging the **OpenFDA API**, Pharmate ensures that users have up-to-date and accurate guides for the medicines they consume. 

### ✨ Key Features
* **Daily Tracker**: View today's and upcoming medicines grouped by time and assigned person. Mark them as taken with a simple tap.
* **Cabinet (Inventory Management)**: Keep track of your pill stock. Know exactly how many pills are left for each medication to avoid running out.
* **Smart Medicine Search**: Search for any medicine name and retrieve real-time data from the OpenFDA API.
* **Detailed Medicine Guides**: Access crucial information such as Brand Name, Generic Name, Purpose, Usage, and Warnings directly within the app.
* **Robust Authentication**: Secure sign-up, sign-in, and password recovery features.
* **Dark Mode Support**: Seamlessly toggle between Light and Dark themes from the settings menu for a comfortable viewing experience at night.

---

## 📸 Screenshots



<table>
  <tr>
    <td align="center"><b>Sign In</b></td>
    <td align="center"><b>Sign Up</b></td>
    <td align="center"><b>Forgot Password</b></td>
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/6392ee0a-1a53-4c3f-8c98-ebc57d5d041c" width="250" alt="Sign In"/></td>
    <td><img src="https://github.com/user-attachments/assets/37907d76-71db-4323-b55e-ba754caa4155" width="250" alt="Sign Up"/></td>
    <td><img src="https://github.com/user-attachments/assets/b58e1b5d-c64f-4a5f-bfaa-d5be0b7f0a60" width="250" alt="Forgot Password"/></td>
  </tr>
  <tr>
    <td align="center"><b>My Medicines</b></td>
    <td align="center"><b>My Cabinet</b></td>
    <td align="center"><b>Add New Medicine</b></td>
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/2bcc8153-d8ed-4b7e-a875-cb1d25d02494" width="250" alt="Tracker"/></td>
    <td><img src="https://github.com/user-attachments/assets/8fac1cbb-66ab-45f7-8721-3bd8d87e3a36" width="250" alt="Cabinet"/></td>
    <td><img src="https://github.com/user-attachments/assets/80eccad7-a8c1-4a59-996d-ff4ee205a265" width="250" alt="Add Medicine"/></td>
  </tr>
  <tr>
    <td align="center"><b>Search for Medicines #1</b></td>
    <td align="center"><b>Search for Medicines #2</b></td>
    <td align="center"><b>Medicine Details</b></td>
  </tr>
  
  <tr>
    <td><img src="https://github.com/user-attachments/assets/f6408ee5-bbcd-4554-aa03-759a85f654ab" width="250" alt="Search Medicine"/></td>
    <td><img src="https://github.com/user-attachments/assets/fb7dc830-47e0-4462-ba0b-3a279fe789f2" width="250" alt="Search Medicine"/></td>
    <td><img src="https://github.com/user-attachments/assets/5bc6e78a-ef91-4132-8994-0191740ab6d6" width="250" alt="Details"/></td>
  </tr>
  
  <tr>
    <td align="center"><b>Settings</b></td>
    <td align="center"><b>Dark Theme</b></td>
    <td align="center"><b>Splash Screen</b></td>

  </tr>
  
  <tr>
    <td><img src="https://github.com/user-attachments/assets/44bdd601-5776-48c1-bb42-8e0132fae4a3" width="250" alt="Settings"/></td>
    <td><img src="https://github.com/user-attachments/assets/f770f729-e908-4fb4-bc7d-ee6a473fba01" width="250" alt="Dark Theme"/></td>
    <td><img src="https://github.com/user-attachments/assets/294ca268-7214-4a48-83a2-1e44741402d1" width="250" alt="Splach Screen"/></td>

  </tr>
</table>

---

## 🛠️ Tech Stack & Architecture

This project is built using modern Flutter development practices to ensure scalability, maintainability, and top-tier performance.

### Core Data Handling
Instead of dealing directly with raw JSON maps throughout the UI, all data fetched from the `https://open.fda.gov/apis/` endpoint is strictly serialized into robust **Dart Models (Objects)**. This ensures type safety, prevents null errors, and makes the UI code cleaner when displaying complex details.

### Packages Used

* **[Flutter BLoC](https://pub.dev/packages/flutter_bloc)**: The core state management solution used to separate business logic from the UI. It powers the dynamic updates in the Tracker, Cabinet inventory changes, and API fetching states.
* **[Dio](https://pub.dev/packages/dio)**: A powerful HTTP client for Dart used to handle network requests to the OpenFDA API efficiently.
* **[Go Router](https://pub.dev/packages/go_router)**: Utilized for declarative and robust routing/navigation across the app's various screens (Home, Cabinet, Settings, Details, etc.).
* **[Get It](https://pub.dev/packages/get_it)**: Used as a Service Locator for Dependency Injection (DI). It manages instances of API clients, repositories, and BLoCs globally.
* **[Flutter Hooks](https://pub.dev/packages/flutter_hooks)**: Used to cleanly manage local states, such as `TextEditingControllers` for sign in, registration, and medicine search forms.
* **[FpDart](https://pub.dev/packages/fpdart)**: Introduces functional programming concepts to handle API errors, null safety, and data parsing cleanly (using `Either`, `Option`).
* **[Any Image View](https://pub.dev/packages/any_image_view)**: Ensures seamless and optimized rendering of various image formats throughout the application.
* **[Gap](https://pub.dev/packages/gap)**: A simple tool used to create clean, consistent whitespace between UI widgets without relying heavily on `Padding` or `SizedBox`.
* **[Intl](https://pub.dev/packages/intl)**: Essential for formatting dates and times correctly on the Tracker page.
* **[Flutter Launcher Icons](https://pub.dev/packages/flutter_launcher_icons) & [Flutter Native Splash](https://pub.dev/packages/flutter_native_splash)**: Used to configure the custom app icon and the seamless native splash screen experience on both iOS and Android.

---
