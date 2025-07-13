# app/helpers/bootstrap_link_renderer.rb
class BootstrapLinkRenderer < WillPaginate::ActionView::LinkRenderer
  def container_attributes
    { class: 'pagination' }
  end

  def page_number(page)
    if page == current_page
      tag :li, tag(:span, page, class: 'page-link'), class: 'page-item active'
    else
      tag :li, link(page, page, class: 'page-link'), class: 'page-item'
    end
  end

  def gap
    tag :li, link(super, '#', class: 'page-link'), class: 'page-item disabled'
  end

  def previous_or_next_page(page, text, classname)
    if page
      tag :li, link(text, page, class: 'page-link'), class: 'page-item'
    else
      tag :li, tag(:span, text, class: 'page-link'), class: 'page-item disabled'
    end
  end

  def html_container(html)
    tag :nav, tag(:ul, html, class: 'pagination')
  end
end
