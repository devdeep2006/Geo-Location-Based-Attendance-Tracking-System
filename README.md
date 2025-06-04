# GeoNirikshan - Geolocation-Based Attendance Tracking System

GeoNirikshan is a smart and scalable attendance tracking system tailored for modern workplaces. It leverages **geolocation** and **biometric verification** to securely automate employee attendance, offering dedicated platforms for both employees and administrators.

---

## 🌐 Overview

GeoNirikshan automates attendance by detecting an employee's proximity to the workplace and initiating biometric verification. It includes:

- Geofenced automatic attendance within a 200m radius.
- Dual biometric verification (fingerprint + facial recognition).
- Real-time dashboards for admins.
- Leave management and detailed logs for both employees and employers.

---

## 📱 Employee Mobile Application Features

- ✅ **Automatic Attendance**: Logged automatically when within 200m of assigned office location.
- 🔒 **Dual Biometric Verification**: Fingerprint + Face recognition for secure verification.
- 📝 **Manual Check-In/Out**: Available as fallback option.
- 📊 **Daily Logs**: Includes working hours, break durations, total time.
- 📅 **Leave Application**: Built-in leave request module.

---

## 🖥️ Admin Web Dashboard Features

- 📍 **Real-Time Stats**: Visual display of on-site/off-site employees.
- 📈 **Graphs & Logs**: Attendance trends and employee-specific logs.
- 👤 **Employee Profiles**: Historical attendance records, leaves, and activity.
- 🌍 **Map-Based Management**: Create/manage office zones using interactive maps.
- 🗂️ **Leave Management**: Review and respond to employee leave applications.

---

## 🛠 Tech Stack

| Platform       | Technologies                           |
|----------------|----------------------------------------|
| Frontend (Web) | Next.js, Tailwind CSS                  |
| Mobile App     | Flutter (Dart), Kotlin (Android), Swift (iOS) |
| UI/UX Design   | Figma                                  |
| Authentication| Firebase                                |
| Databases      | PostgreSQL (relational), MongoDB (logs)|
| Visualization  | Matplotlib                             |

---

## 🔄 Project Workflow

1. 📍 **User enters** predefined office geofence or manually initiates check-in.
2. 🔐 **Biometric verification** (face + fingerprint) is triggered.
3. 🗃️ **Attendance data** is recorded and securely sent to the server.
4. 📊 **Admin dashboard** updates in real-time for monitoring and leave handling.

---

## 📸 Screenshots

### Web Admin Dashboard  
Login Page:
![Login Page](./Screenshot 2025-06-05 024253.png)

Admin Dashboard:
![Admin Dashboard](Screenshot 2025-06-05 024308.png)

Employee Data View:
![Employee Date View](Screenshot 2025-06-05 024319.png)





---

### Mobile App Interface  


---

## 🚀 Future Scope

- 💵 **Payroll Integration**: Direct link between attendance and salary.
- 🏫 **Institutional Expansion**: Adaptation for schools, universities, and large events.
- 🔔 **Smart Notifications**: Alerts for missed check-ins, unusual patterns, etc.
- 📊 **Advanced Analytics**: Predictive attendance and perf
