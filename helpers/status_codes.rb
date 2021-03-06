module StatusCodesHelper
  def not_allowed(body = nil)
    error 405, body
  end

  def created
    status 201
  end

  def ok
    status 200
  end

  def no_content
    status 204
  end
end