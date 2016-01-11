def full_title(page_title)
  base_title = "Callboard"
  if page_title.empty?
    base_title
  else
    "#{base_title} | #{page_title}"
  end
end

def sign_in(user, options={})
    visit user_session_path
    fill_in "Email",           with: user.email
    fill_in "Password",        with: user.password
    click_button "Sign in"
end

def login_as_casual_user
    @request.env["devise.mapping"] = Devise.mappings[:user]
     if(@logined != nil)
         sign_out :user
    end
    sign_in users(:casual)
    @logined = true
end
