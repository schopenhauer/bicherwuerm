require 'open3'

class BackupsController < ApplicationController
  before_action :authenticate_user!

  def show
    @files = Dir.glob(File.join(BACKUP_FOLDER, '*.sql'))
  end

  def new
    config = ActiveRecord::Base.connection_db_config.configuration_hash
    if Rails.env == 'production'
      database = config[:database]
      username = config[:username]
      timestamp = Time.now.strftime('%Y-%m-%d_%H-%M-%S')
      command = "mysqldump -u #{username} #{database} -p > " + File.join(BACKUP_FOLDER, "#{database}-#{timestamp}.sql")
      stdin, stdout, _stderr = Open3.popen3(command)
      stdin.puts(config[:password])
      if stdout.gets.nil?
        flash[:success] = 'The new backup has been launched.'
      else
        flash[:error] = "Oops, something went wrong. The console returned an error message: #{stdout.gets}"
      end
    else
      flash[:warning] = 'WARNING: The database backup tool is only available in a production environment.'
    end
    redirect_back fallback_location: { action: 'show' }
  end

  def remove
    if File.delete(params[:file])
      pretty = File.basename(params[:file])
      flash[:success] = "The backup file (#{pretty}) has been deleted."
    else
      flash[:warning] = 'There may have been a problem deleting the selected file. Please try again later.'
    end
    redirect_back fallback_location: { action: 'show' }
  end

  def download_sql
    filename = "#{params[:file]}.sql"
    file = File.join(BACKUP_FOLDER, filename)
    send_data File.read(file), disposition: 'attachment', filename: filename, type: 'text/plain'
  end

  def download_zip
    filename = "#{params[:file]}.sql"
    file = File.join(BACKUP_FOLDER, filename)
    send_data compress(File.read(file)), disposition: 'attachment', filename: "#{params[:file]}.zip", type: 'application/zip'
  end

  private

  def compress(data)
    ActiveSupport::Gzip.compress data
  end

end
