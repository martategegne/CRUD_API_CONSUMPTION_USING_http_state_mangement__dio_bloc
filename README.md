#  Digital Time Capsule App

## Student Information

| Name | ID | Section |
|------|----|---------|
| Marta Tegegne | UGR/4457/16| Section-1 |

## Description

A Flutter application that performs full CRUD (Create, Read, Update, Delete) operations using a public REST API.  
This project demonstrates clean architecture, Bloc state management, Dio networking, and local caching.


##  Features


-  Fetch posts from API

-  Create new memory (Post)

-  Update existing memory

-  Delete memory

-  Search functionality

-  Pull-to-refresh

-  Local caching using SharedPreferences

-  Smooth UI updates using Bloc

##  Tech Stack

- **Flutter**

- **Bloc (State Management)**

- **Dio (HTTP Client)**

- **SharedPreferences (Local Storage)**

- **REST API (DummyJSON)**


##  Project Structure

lib/

│

├── bloc/

│ └── post/

│ ├── post_bloc.dart

│ ├── post_event.dart

│ └── post_state.dart
│

├── models/

│ └── post_model.dart

│

├── repository/

│ └── post_repository.dart

│

├── services/

│ ├── api_service.dart

│ └── local_storage.dart

│

├── screens/

│ ├── home_screen.dart

│ └── add_edit_screen.dart

│

├── widgets/

│ └── post_card.dart

│

└── main.dart

##  API Used

- https://dummyjson.com/posts


##  How It Works


- Bloc handles all state management

- Repository abstracts API + local storage

- Dio handles network requests

- Local storage ensures offline capability

- UI reacts automatically to state changes



##  Screenshots


###  Home Screen
<img width="1023" height="729" alt="image" src="https://github.com/user-attachments/assets/3eb03dd1-bf2a-441b-820f-4d7e2bc61c8e" />


###  Add Post
<img width="1024" height="726" alt="image" src="https://github.com/user-attachments/assets/1b5705b1-d15a-45d4-8c9b-806a4c69eb1a" />

<img width="1021" height="728" alt="image" src="https://github.com/user-attachments/assets/40b50e04-4430-4e8d-9084-9a86f22e2ff5" />


###  Edit Post
<img width="1024" height="725" alt="image" src="https://github.com/user-attachments/assets/4c636f6c-207d-471f-90eb-4ae0ae1a336b" />

<img width="1024" height="730" alt="image" src="https://github.com/user-attachments/assets/993208f3-b956-405f-826e-503382e67d6d" />

### delete post
<img width="1024" height="730" alt="image" src="https://github.com/user-attachments/assets/de609852-4014-4362-9fe2-96bb059a7eef" />


<img width="1023" height="728" alt="image" src="https://github.com/user-attachments/assets/d8006ed5-c8f3-4eab-ac77-25276bf7c111" />

<img width="1024" height="728" alt="image" src="https://github.com/user-attachments/assets/76852268-41a9-47ca-851c-4f0b8be65ed2" />

##  Error Handling


- API failure fallback to local cache

- Try-catch implemented in repository

- Error states handled via Bloc

##  Assignment Requirements Covered


✔ CRUD operations using public API  

✔ Bloc state management  

✔ Dio for networking  

✔ Clean architecture  

✔ Error & loading handling  

✔ GitHub repository with screenshots  


## Submission

GitHub Repository Link:  
(https://github.com/martategegne/CRUD_API_CONSUMPTION_USING_http_state_mangement__dio_bloc)
