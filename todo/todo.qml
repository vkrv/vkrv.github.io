Item {
	anchors.fill: context;

	Column {
		width: 100% > 600 ? 600 : 100%;
		y: 20;
		spacing: 20;
		anchors.horizontalCenter: parent.horizontalCenter;

		Item {
			width: 90%; x: 10;
			height: 22;
			TextInput {
				id: todoInput;
				width: 90%;
				border.bottom.width: 1;
				border.color: "#bbb";
				font.pixelSize: 20;
			}
			Text {
				x: 91%; y: 5;
				color: "#2196F3";
				text: "ADD";
				font.pixelSize: 16;
				HoverClickMixin { cursor: "pointer"; }
				onClicked: { 
					if (todoInput.text !== "") {
						todoList.model.append({ "text": todoInput.text})
						todoInput.text = ""
					}
				}
			}
		}

		ListView {
			id: todoList;
			width: 100%;
			height: context.height - 100;

			model: ListModel {
				ListElement { text: "develop TODO list"; }
				ListElement { text: "as simple as possible"; }
				ListElement { text: "simplier than ever"; }
			}

			delegate: WebItem {
				id: todoItem;
				width: 100%;
				height: todoText.height + 40;
				property int idx: model.index;
				property bool done;
				radius: 10;
				cursor: "default";
				color: hover ? "#f5f5f5" : "white";

				Text {
					id: todoText;
					width: 90%; x: 10;
					y: 10;
					wrapMode: Text.WordWrap;
					text: parent.done ? "<strike>" + model.text + "</strike>" : model.text;
					color: parent.done ? "#556655" : "#424242";
					font.pixelSize: 20;
					font.weight: 300;
				}

				Row {
					y: todoText.height + 15; x: 10;
					opacity: parent.hover;
					spacing: 10;
					Behavior on opacity { Animation { duration: 500; }}
					Text {
						color: todoItem.done ? "gray" : "#558B2F";
						text: todoItem.done ? "UNDONE" : "DONE";
						font.pixelSize: 16;
						HoverClickMixin { cursor: "pointer"; }
						onClicked: { todoItem.done = !todoItem.done; }
					}
					Text {
						color: "#F44336";
						text: "REMOVE";
						font.pixelSize: 16;
						HoverClickMixin { cursor: "pointer"; }
						onClicked: { todoList.model.remove(todoItem.idx) }
					}
				}
			}
		}
	}
}