lgi = require 'lgi'
sqlite = require 'lsqlite3'

gtk = lgi.Gtk
pixbuf = lgi.GdkPixbuf.Pixbuf

gtk.init()

bld = gtk.Builder()
bld:add_from_file('lab-06.glade')

ui = bld.objects

rdrTxt = gtk.CellRendererText {}
rdrPix = gtk.CellRendererPixbuf {}

c1 = gtk.TreeViewColumn { title = 'Name', {rdrTxt, { text = 1 }}}
c2 = gtk.TreeViewColumn { title = 'Value', {rdrTxt, { text = 2 }}}
c3 = gtk.TreeViewColumn { title = 'Image', {rdrPix, { pixbuf = 3 }}}

ui.lst_items:append_column(c1)
ui.lst_items:append_column(c2)
ui.lst_items:append_column(c3)

db = sqlite.open('lab-06.db')

for row in db:nrows("SELECT * FROM list") do
  px = pixbuf.new_from_file(row.image)
  
  el = ui.storeItems:append()
  ui.storeItems[el] = { [1] = row.name, [2] = row.value, [3] = px }
end

db:close()
