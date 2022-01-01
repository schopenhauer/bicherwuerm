module StaticPagesHelper

  def parameterize(params)
    URI.escape(params.collect { |k, v| "#{k}=#{v}" }.join('&'))
  end

end
