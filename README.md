# bicherwuerm

![Bicherwuerm](https://github.com/schopenhauer/bicherwuerm/raw/main/app/assets/images/bookworm.png)

Bicherwuerm is a book management app developed with [Ruby on Rails](http://rubyonrails.org), which allows you to add, edit and remove books in your library and manage associated records of publishers, genres, categories, collections and colours.

The app can access to the [Amazon Product Advertising API](https://github.com/hakanensari/vacuum) and [Google Custom Search JSON API](https://developers.google.com/custom-search/v1/overview) to fetch book details and covers. You need to have an active [Amazon Associates](https://affiliate-program.amazon.com) account to be able to use the Amazon API.

## Configuration

### Minimal configuration

By default, the app uses SQLite in development and MariaDB/MySQL in production environments respectively. The app picks up the `DATABASE_URL` environment variable in production:

```
mysql2://username:password@host:port/database
```

### Optional configuration

You can run `rails credentials:edit` to set up credentials for the [Amazon Product Advertising API](https://github.com/hakanensari/vacuum), the [Google Custom Search JSON API](https://developers.google.com/custom-search/v1/overview) and/or the [SendGrid API](https://sendgrid.com/docs/API_Reference/index.html). In this case, please make sure to provide the `config/master.key` file or set the `RAILS_MASTER_KEY` environment variable.

```
aws:
  access_key: ...
  secret_key: ...

google:
  client_cx: ...
  client_key: ...

sendgrid:
  api_key: ...
```

Furthermore, you can customise the app's default values in the `config/app.yml`.

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
