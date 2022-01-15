APP_CONFIG = YAML.load_file("#{Rails.root}/config/app.yml")[Rails.env]

BACKUP_FOLDER = File.join(Rails.root, 'db/backup')

DEFAULT_USER = { name: 'John Smith', email: 'john.smith@bicherwuerm.org' }
DEFAULT_CATEGORY = { name: 'Book' }
DEFAULT_LANGUAGE = { name: 'English', local: 'English', acronym: 'en' }
DEFAULT_GENRE = { name: 'Uncategorized' }
DEFAULT_PUBLISHER = { name: 'Uncategorized' }
