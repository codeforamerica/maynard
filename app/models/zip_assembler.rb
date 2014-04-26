class ZipAssembler
  class << self
    def assemble_zip_archive(project)
      return unless project

      begin
        filenames = project.documents.filenames
      rescue DropboxError
        puts "***Storage error: looks like the necessary documents are not where they're supposed to be!"
      else
        zip_filename = "#{ Rails.root }/tmp/#{ project.name_with_project_number }-#{ Time.now.to_i }.zip_#{ Process.pid }"

        if !filenames.empty?
          Zip::File.open(zip_filename, Zip::File::CREATE) do |zipfile|
            # Generate a file manifest for the bid package.
            readme_str = File.join(Rails.root, "tmp/readme_#{ Process.pid }.txt")
            bid_package_readme = File.open(readme_str, "w")
            bid_package_readme << "You should find the following files in this bid package for contract ##{ project.project_number }:\n"

            filenames.each_with_index do |filename, index|
              original_filename = filename.split('/').last
              bid_package_readme << "\n- #{ original_filename }"
              doc = Document.where(document_file_name: original_filename).first

              if doc
                # Include this Process.pid stuff for Heroku's filehandling, as per https://devcenter.heroku.com/articles/read-only-filesystem
                destination = File.join(Rails.root, "tmp/#{ original_filename }_#{ Process.pid }")
                doc.document.copy_to_local_file(destination)
                zipfile.add(original_filename, destination)
              end
            end

            # TODO: Contracting officer can customize the message that goes here.
            bid_package_readme << "\n\nSince you've registered for updates, you will automatically receive notifications of changes to this opportunity by email!"
            bid_package_readme.close

            zipfile.add("readme.txt", bid_package_readme)
            zip_filename
          end
        else
          false
        end
      end
    end
  end
end
