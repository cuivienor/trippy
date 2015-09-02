# Trippy

WDI Project 3, name pending


Contributors: James Leisy, Johnathan Chei, David Vinkesteijn, Peter Petrov
Advisors: Andrew Fritz, Sung Choi

# 
Taken from http://stackoverflow.com/questions/5267998/rails-3-field-with-errors-wrapper-changes-the-page-appearance-how-to-avoid-t

by Adrien Macniel

config.action_view.field_error_proc = Proc.new { |html_tag, instance| 
html_tag
}

Appears in config/application.rb lines 34 - 36
