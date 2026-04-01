VibeMatch 💫

A modern social discovery and messaging platform

VibeMatch is a mobile application designed to help people discover, connect, and chat with others who share similar vibes and interests. The app focuses on smooth user experience, secure authentication, and real-time communication.

The project is built using Flutter for the frontend and FastAPI for the backend, providing a fast and scalable architecture.

🚀 Features
🔐 Authentication System
User Signup
User Login
Secure password handling
API-based authentication
👤 User Profiles
Create and manage profiles
Store user details like name, email, and preferences
Profile-based interactions
🔎 Discover Users
Browse other users
Find people with similar interests
💬 Messaging
Chat with matched users
Clean and responsive chat interface
⚡ API-Based Architecture
Backend APIs built with FastAPI
Frontend communicates with backend via REST APIs
🛠 Tech Stack
Frontend
Flutter
Dart
HTTP package for API communication
Backend
FastAPI
Python
Uvicorn server
Pydantic for data validation
Bcrypt for password hashing
Database
SQLite / PostgreSQL (depending on deployment)
Version Control
Git
GitHub
📂 Project Structure
Frontend (Flutter)
lib/
 ┣ core/
 ┃ ┣ theme/
 ┃ ┗ utils/
 ┣ features/
 ┃ ┣ auth/
 ┃ ┣ home/
 ┃ ┣ discover/
 ┃ ┗ messages/
 ┗ main.dart
Backend (FastAPI)
vibematch_backend/
 ┣ app/
 ┃ ┣ main.py
 ┃ ┣ models/
 ┃ ┣ routes/
 ┃ ┣ schemas/
 ┃ ┗ database.py
 ┣ venv/
 ┗ requirements.txt
⚙️ Installation & Setup
1️⃣ Clone the repository
git clone https://github.com/ajilaries/VibeMatch.git
cd VibeMatch
2️⃣ Backend Setup

Create virtual environment:

python -m venv venv

Activate environment:

Windows

venv\Scripts\activate

Install dependencies:

pip install -r requirements.txt

Run the backend server:

uvicorn app.main:app --reload

Backend will run at:

http://127.0.0.1:8000
3️⃣ Frontend Setup

Go to Flutter project folder:

cd vibematch_app

Install dependencies:

flutter pub get

Run the app:

flutter run
🔌 API Endpoints
Authentication

Signup

POST /signup

Login

POST /login
📱 Screens (Planned / In Development)
Login Screen
Signup Screen
Home Screen
Discover Screen
Chat Screen
Profile Screen
🔒 Security Improvements (Future)
JWT authentication
Refresh tokens
Password hashing improvements
Rate limiting
🌟 Future Features
AI-based match suggestions
Real-time chat using WebSockets
Push notifications
User verification system
Interest-based matching
👨‍💻 Developer

Ajil
Student Developer passionate about building modern applications.

📜 License

This project is currently for learning and development purposes.