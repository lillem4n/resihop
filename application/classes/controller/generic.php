<?php defined('SYSPATH') OR die('No direct access allowed.');

class Controller_Generic extends Resihopcontroller
{

	public function action_index($URI = 'welcome')
	{
		// Empty string defaults to 'welcome'
		if ($URI == '') $URI = 'welcome';

		// Set the name of the template to use
		$this->xslt_stylesheet = 'generic';

		// Initiate the page model
		$content_page = new Content_Page(Content_Page::get_page_id_by_uri($URI));

		// Create the DOM node <page>
		$this->xml_content_page = $this->xml_content->appendChild($this->dom->createElement('page'));

		// And load the page data into it
		$page_data = $content_page->get_page_data();

		$counter = 0;
		foreach ($page_data['type_ids'] as $template_field_id => $type_id)
		{
			$content_type               = new Content_Type($type_id);
			if ($content_type->get_type_id())
			{
				$page_data[$counter.'type'] = array_merge(
					                              $content_type->get_type_data(),
					                              array('template_field_id' => $template_field_id)
					                            );

				foreach (Content_Content::get_contents_by_type($type_id) as $content)
				{
					$page_data[$counter.'type']['contents']['content'] = array(
						'id'  => $content['id'],
						'raw' => $content['content'],
					);
				}
			}
			$counter++;
		}
		unset($page_data['type_ids']);

		xml::to_XML($page_data, $this->xml_content_page, NULL, array('id', 'template_field_id'));

		// We need to put some HTML in from our transformator
		// The reason for all this mess is that we must inject this directly in to the DOM, or else the <> will get destroyed
		$XPath = new DOMXpath($this->dom);
		foreach ($content_page->get_page_data('type_ids') as $type_id)
		{
			foreach ($XPath->query('/root/content/page/type[@id=\''.$type_id.'\']/contents/content/raw') as $raw_content_node)
			{
				$html_content = call_user_func(Kohana::config('content.content_transformator'), $raw_content_node->nodeValue);
				$html_node    = $raw_content_node->parentNode->appendChild($this->dom->createElement('html'));
				xml::xml_to_DOM_node($html_content, $html_node);
			}
		}
	}

}
