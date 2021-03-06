#!/usr/bin/ruby
require 'bundler/setup'
require 'digipolitan-apps-tools'

Digipolitan::UI.success("--- Step: Rename Xcodeproj ---")
Digipolitan::Xcodeproj.rename_project()
if File.exists?("./Podfile")
  system("pod repo update --silent")
  system("pod install")
end
Digipolitan::UI.success("--- Step: Clear installer ---")
files_to_clear = ["CHANGELOG.md", "CODE_OF_CONDUCT.md", "CONTRIBUTING.md", "LICENSE", "README.md"]
files_to_clear.each { |f|
  Digipolitan::UI.message("- #{f}")
}
if Digipolitan::UI.confirm("Would you like to clear these Digipolitan files ?")
  files_to_clear.each { |f|
    Digipolitan::FileUtils.write_to_file(f)
  }
end
if Digipolitan::UI.confirm("Delete the installer file ?")
  File.delete(__FILE__)
end
