module ApplicationHelper

  def config
    @config ||= OpenStruct.new YAML.load(open('./config.yml').read)
  end
  
  def abs_path
    config.fileserver_root + rel_path
  end
  
  def rel_path
    request.path_info
  end
end