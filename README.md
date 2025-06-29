## Project Overview

The Movies App is designed to provide users with a seamless experience for browsing and discovering movies. Built with Clean Architecture, this app ensures maintainability, scalability, and testability.

# Architecture Overview
The app is structured following the **Clean Architecture** principles using **MVVM**, which emphasize separation of concerns and independence of frameworks, UI, and databases. The main layers in this architecture are:
**Presentation Layer**
**Domain Layer**
**Data Layer**

#Layer Descriptions

**Presentation Layer**
Purpose: This layer is responsible for displaying data to the user and handling user interactions.
Components: It includes UI components such as MoviesListViewController.swift.
Responsibilities: It communicates with the Domain layer to fetch data and update the UI accordingly.

**Domain Layer**
Purpose: The Domain layer contains the business logic of the application.
Components: It includes entities and use-cases, such as PopularMovies.swift.
Responsibilities: This layer is independent of any other layers and can be tested easily.

**Data Layer**
Purpose: This layer manages data operations, including fetching data from the network or local storage.
Components: It includes repositories and data sources.
Responsibilities: It provides data to the Domain layer and abstracts the data source details.

## Supported iOS version 
iOS 14 >

##  Appearance
Project supports light and dark modes.

## Compatible Devices
Project is tested on a real iPhone xs and iPhone Simulators 14 and 14 pro max and the UI is compatible. 

## Test Coverage
The project includes unit test cases for critical scenarios, as well as UI test cases for the home screen.

## More info
Data is saved locally using **Core Data**.
