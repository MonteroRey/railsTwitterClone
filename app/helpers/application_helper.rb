module ApplicationHelper
    def full_title(page_title)              ##### render in application.html.erb in the layouts view  
        base_title = "Twitter Clone"
        if page_title.empty?
          base_title
        else
          "#{page_title} | #{base_title}"
        end
    end
end
