# bicherwuerm

![Bicherwuerm](https://github.com/schopenhauer/bicherwuerm/raw/main/app/assets/images/bookworm.png)

Bicherwuerm is a book management app developed with [Ruby on Rails](http://rubyonrails.org), which allows you to add, edit and remove books in your library and manage associated records of publishers, genres, categories, collections and colours.

The app provides access to the [Amazon Product Advertising API](https://github.com/hakanensari/vacuum) and [Google Custom Search JSON API](https://developers.google.com/custom-search/v1/overview) to fetch book details and cover images. You need to have an active [Amazon Associates](https://affiliate-program.amazon.com) account to be able to use the Amazon API.

## Configuration

### Minimal configuration

By default, the app uses SQLite and MariaDB/MySQL in development and production environments respectively. In production, the app picks up the `DATABASE_URL` environment variable (e.g. _mysql2://&lt;username&gt;:&lt;password&gt;@&lt;host&gt;/&lt;database&gt;_).

You should run `rails credentials:edit` to configure the credentials for the [Amazon Product Advertising API](https://github.com/hakanensari/vacuum), the [Google Custom Search JSON API](https://developers.google.com/custom-search/v1/overview) and the [SendGrid API](https://sendgrid.com/docs/API_Reference/index.html). Please make sure to provide the `config/master.key` file or set the `RAILS_MASTER_KEY` environment variable.

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

### Optional configuration

You may customise some of the app's default values in the `config/app.yml`.

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
