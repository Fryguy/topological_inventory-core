class Source < ActiveRecord::Base
  has_many :endpoints, :dependent => :destroy, :autosave => true
  delegate :scheme, :scheme=, :host, :host=, :port, :port=, :path, :path=,
           :to => :default_endpoint, :allow_nil => true

  def default_endpoint
    default = endpoints.detect(&:default)
    default || endpoints.build(:default => true)
  end


  # Container Inventory Objects
  has_many :container_groups,    :dependent => :destroy
  has_many :container_templates, :dependent => :destroy
  has_many :container_projects,  :dependent => :destroy

  # Service Catalog Inventory Objects
  has_many :service_offerings,       :dependent => :destroy
  has_many :service_instances,       :dependent => :destroy
  has_many :service_parameters_sets, :dependent => :destroy
end
