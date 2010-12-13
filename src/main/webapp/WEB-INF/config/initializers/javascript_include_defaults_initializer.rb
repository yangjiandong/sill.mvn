# This function will return references to the JavaScript files created by the rails command in your
# public/javascripts directory. Using it is recommended as the browser can then cache the libraries
# instead of fetching all the functions a new on every request
Rails.logger.info "\n Initializing javascript_include_defaults "
#ActionView::Helpers::AssetTagHelper::register_javascript_include_default('dhtml_form_validation', 'tabcontent')

########   DO    NOT     CHANGE      THE    ORDER    OF    EXT    js  files !!!!!!!!!!!!!!!!!!!
js_array = ['prototype','scriptaculous']

if Rails.env.production?
  js_array += ['ext/adapter/prototype/ext-prototype-adapter','ext/ext-all.js']
else
  js_array += ['ext/adapter/prototype/ext-prototype-adapter-debug','ext/ext-all-debug.js']
end

# Now some Extensions to Ext_js will be loaded
js_array += [
  'ext-extensions/ext.ux.form.datetime',      # To format the date in a proper way for each country
  'ext-extensions/ext.ux.grid.search',        # for the search field in a grid
  'ext-extensions/ext.ux.grid.checkcolumn',   # To render a checkbox in a grid column
  'ext-extensions/ext.tree.columntree',       # for the columntree
  'ext-extensions/ext.tree.tree-serializer',  # for the columntree to serialze the content
  'ext-extensions/exportgridtoexcel',         # to export grid content to excel
  'ext-extensions/ext.ux.themecyclebutton',   # For the theme selection button
  'ext-extensions/ext.ux.oosubmitaction',     # To submit Ext.form fields (check, combo, date) with the underlying raw data
  #  'ext-extensions/ext.ux.gmappanel',          # Ext extension for Google Maps
  'ext-extensions/ext.ux.comboboxrenderer',   # To render in comboboxes in EditorGrids the text and not the value
  'ext-extensions/ext.form.fileuploadfield',  # To upload a file from a form panel
  'ext-extensions/grid_filters/ux/menu/EditableItem',  # now comes all for gridfilters
  'ext-extensions/grid_filters/ux/menu/ListMenu',
  'ext-extensions/grid_filters/ux/menu/RangeMenu',
  'ext-extensions/grid_filters/ux/menu/TreeMenu',
  'ext-extensions/grid_filters/ux/grid/GridFilters',
  'ext-extensions/grid_filters/ux/grid/filter/Filter',
  'ext-extensions/grid_filters/ux/grid/filter/StringFilter',
  'ext-extensions/grid_filters/ux/grid/filter/DateFilter',
  'ext-extensions/grid_filters/ux/grid/filter/ListFilter',
  'ext-extensions/grid_filters/ux/grid/filter/NumericFilter',
  'ext-extensions/grid_filters/ux/grid/filter/BooleanFilter',
  'ext-extensions/ext.ux.state.httpprovider',   # To save the state on the server side
  'ext-extensions/ext_ux_form_htmleditor/Ext.ux.HtmlEditor.Plugins-0.2-all'
  # 'ext-extensions/ext_ux_form_htmleditor/ext.ux.form.htmleditor.word',
  # 'ext-extensions/ext_ux_form_htmleditor/ext.ux.form.htmleditor.divider',
  # 'ext-extensions/ext_ux_form_htmleditor/ext.ux.form.htmleditor.table',
  # 'ext-extensions/ext_ux_form_htmleditor/ext.ux.form.htmleditor.hr',
  # 'ext-extensions/ext_ux_form_htmleditor/ext.ux.form.htmleditor.indentoutdent',
  # 'ext-extensions/ext_ux_form_htmleditor/ext.ux.form.htmleditor.midascommand',
  # 'ext-extensions/ext_ux_form_htmleditor/ext.ux.form.htmleditor.removeformat',
  # 'ext-extensions/ext_ux_form_htmleditor/ext.ux.form.htmleditor.specialcharacters',
  # 'ext-extensions/ext_ux_form_htmleditor/ext.ux.form.htmleditor.subsuperscript'
]

###### END  OF DO NOT CHANGE ORDER

ActionView::Helpers::AssetTagHelper.register_javascript_expansion :defaults => js_array

Rails.logger.info "-> initialized"