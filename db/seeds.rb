# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create default admin user
User.find_or_create_by!(email: "root@root.pl") do |user|
    user.password = "admin123"
    user.password_confirmation = "admin123"
    user.role = :admin
  end

 # Create default admin user Writer
 writer = User.find_or_create_by!(email: "jan_kowalski@blog.pl") do |user|
    user.password = "janek123"
    user.password_confirmation = "janek123"
    user.role = :writer
  end

 # Create default admin user Writer
 User.find_or_create_by!(email: "tomek_nowak@blog.pl") do |user|
    user.password = "tomek123"
    user.password_confirmation = "tomek123"
    user.role = :viewer
  end  

  if writer.posts.count == 0
    writer.posts.create!(
      title: "Helo world. pierwszy post",
      body: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      published: true
    )
  
    writer.posts.create!(
        title: "Spring czy RoR ? Co ma przyszłość....",
        body: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        published: true
      )

    writer.posts.create!(
      title: "Praca dla juniorów. Nie jest łatwo....",
      body: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      published: true
    )

  end 