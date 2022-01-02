# bicherwuerm

![Bicherwuerm](https://github.com/schopenhauer/bicherwuerm/raw/main/app/assets/images/bookworm.png)

Bicherwuerm is a book management app developed with [Ruby on Rails](http://rubyonrails.org), which allows you to add, edit and remove books in your library and manage associated records of publishers, genres, categories, collections and colours.

The app provides access to the [Amazon Product Advertising API](https://github.com/hakanensari/vacuum) and [Google Custom Search API](https://developers.google.com/api-client-library/ruby/apis/customsearch/v1) to fetch book details and cover images. You need to have an active [Amazon Associates](https://affiliate-program.amazon.com) account to be able to use the Amazon API.

## Configuration

### Minimal configuration

The app picks up the `DATABASE_URL` environment variable (e.g. _mysql2://&lt;username&gt;:&lt;password&gt;@&lt;host&gt;/&lt;database&gt;_). By default, the app uses SQLite in development and MySQL in production environments.

You can generate a new `config/master.key` file or `RAILS_MASTER_KEY` environment variable the using the `rails credentials:edit` command.

### Advanced configuration

You may customise default values in the `config/app.yml` and `config/database.yml` configuration files.

Set these environment variables to use the [Amazon Product Advertising API](https://github.com/hakanensari/vacuum):

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`

Set these environment variables to use the [Google Custom Search API](https://developers.google.com/api-client-library/ruby/apis/customsearch/v1):

- `GOOGLE_CLIENT_CX`
- `GOOGLE_CLIENT_KEY`

Set this environment variable to use the [SendGrid API](https://sendgrid.com/docs/API_Reference/index.html):

- `SENDGRID_API_KEY`

## Usage

```sh
bundle install
rails db:setup
rails s
```

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## Credits

- [Ruby on Rails](https://rubyonrails.org)
- [Chartkick](https://chartkick.com)
- [Highcharts.js](https://github.com/highcharts/highcharts)
- [Bootswatch](https://bootswatch.com)

## License

The app is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
