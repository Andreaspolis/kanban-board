@tool
extends PanelContainer

##Label node that displays the column title
@export var title_label: Label
##Title for the column of cards.
@export var title: String = "Column Title":
	set(new_title):
		title_label.text = new_title
		title = new_title
