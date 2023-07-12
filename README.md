# Weather API

This is a Rails API that provides weather data. The API fetches weather data from a third-party service and caches it locally. When a request comes in, the API first checks if the requested data is already stored locally. If it's not, the API fetches the data from the third-party service, stores it locally, and then returns the data.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

- Ruby version: 2.7.0 or higher
- Rails version: 6.0.0 or higher
- A local PostgreSQL server

### Installation

Clone this repository:

\`\`\`bash
git clone https://github.com/yourusername/weather-api.git
\`\`\`

Navigate into the project directory:

\`\`\`bash
cd weather-api
\`\`\`

Install the dependencies:

\`\`\`bash
bundle install
\`\`\`

Set up the database:

\`\`\`bash
rails db:create db:migrate
\`\`\`

### Running the application

Start the Rails server:

\`\`\`bash
rails server
\`\`\`

The application should now be running at http://localhost:3000.

## API Endpoints

### GET /weathers

Get weather data for a given city and date range.

Query parameters:

- `city` - The name of the city to get weather data for.
- `start_date` - The start of the date range to get weather data for. Must be in `yyyy-mm-dd` format.
- `end_date` - The end of the date range to get weather data for. Must be in `yyyy-mm-dd` format.

Example request:

\`\`\`http
GET /weathers?city=Berlin&start_date=2023-07-01&end_date=2023-07-31
\`\`\`

## Testing

You can run the test suite with:

\`\`\`bash
rspec
\`\`\`

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.
