#
# Be sure to run `pod lib lint BreadCrumbHeaders.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BreadCrumbHeaders'
  s.version          = '1.1.0'
  s.summary          = 'Breadcrumb-like static headers for iOS used to group screens into a flow.'
  s.description      = <<-DESC
BreadCrumbHeaders is designed to be used whenever you have a few screens that belong to a specific flow. Example, if you have a store checkout flow where you need to collect shipping and billing info, this can be used to notify the user what iss coming and how many steps are needed to complete the flow.
                       DESC
  s.homepage         = 'https://github.com/inderdhir/BreadcrumbHeaders'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Inder Dhir' => 'inderdhir@hotmail.com' }
  s.source           = { :git => 'https://github.com/inderdhir/BreadcrumbHeaders.git', :tag => s.version.to_s }
  s.swift_version    = '5.0'
  s.ios.deployment_target = '11.0'
  s.source_files = 'Sources/BreadCrumbHeaders/**/*'
end
