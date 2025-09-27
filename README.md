# Flight Search App

A Flutter application for searching flights using the Aviationstack API.

## Features

- Search flights by departure/arrival cities and date
- View flight results with details
- Clean architecture with Provider state management
- Error handling and loading states

## Setup Instructions

1. **Get an API Key**
   - Sign up at [Aviationstack](https://aviationstack.com/)
   - Get your free API key

2. **Configure Environment**
   - Create a `.env` file in the root directory
   - Add your API key: `AVIATIONSTACK_API_KEY=your_api_key_here`

3. **Install Dependencies**
   ```bash
   flutter pub get
   ```

4. **Run the App**
   ```bash
   flutter run
   ```

## Demo Mode

If you don't have an API key or want to test the app without setting up the API, the app will automatically use mock data for demonstration purposes. The mock data includes sample flights with realistic details.

## Architecture

This app follows Clean Architecture principles with:
- **Domain Layer**: Entities, Use Cases, and Repository interfaces
- **Data Layer**: Repository implementations and Data Sources
- **Presentation Layer**: UI components and state management with Provider

## Features

- **Flight Search**: Search flights by departure city, arrival city, and date
- **Mock Data Fallback**: Automatically uses demo data when API is not configured
- **Error Handling**: Graceful error handling with user-friendly messages
- **Loading States**: Visual feedback during search operations
- **Responsive UI**: Clean and intuitive user interface