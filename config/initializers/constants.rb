APP_TITLE = 'Bicherwuerm'
APP_CONFIG = YAML.load_file("#{Rails.root}/config/app.yml")[Rails.env]
BACKUP_FOLDER = "#{Rails.root}/public/sql"

VALID_EMAIL_REGEX = %r{\A[\w+\-.]+@[a-z\-.]+\.[a-z]+\z}
VALID_URL_REGEX = %r{^(https?:\/\/)?(?:www\.)?(.*?)\/?$}
VALID_HEX_REGEX = %r{^#(([0-9a-fA-F]{2}){3}|([0-9a-fA-F]){3})$}

DEFAULT_USER = { name: 'Uncategorized', email: 'no-reply@bicherwuerm.org' }
DEFAULT_CATEGORY = { name: 'Book' }
DEFAULT_LANGUAGE = { name: 'Uncategorized', local: 'Uncategorized', acronym: 'unknown' }
DEFAULT_GENRE = { name: 'Uncategorized' }
DEFAULT_PUBLISHER = { name: 'Uncategorized' }
