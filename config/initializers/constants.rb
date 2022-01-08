APP_CONFIG = YAML.load_file("#{Rails.root}/config/app.yml")[Rails.env]
DOMAIN_NAME = ENV['DOMAIN_NAME'] || 'bicherwuerm'

BACKUP_FOLDER = File.join(Rails.root, 'public/sql')

VALID_EMAIL = %r{\A[\w+\-.]+@[a-z\-.]+\.[a-z]+\z}
VALID_COLOR = %r{^#(([0-9a-fA-F]{2}){3}|([0-9a-fA-F]){3})$}

DEFAULT_USER = { name: 'Uncategorized', email: "no-reply@#{DOMAIN_NAME}" }
DEFAULT_CATEGORY = { name: 'Book' }
DEFAULT_LANGUAGE = { name: 'Uncategorized', local: 'Uncategorized', acronym: 'unknown' }
DEFAULT_GENRE = { name: 'Uncategorized' }
DEFAULT_PUBLISHER = { name: 'Uncategorized' }
