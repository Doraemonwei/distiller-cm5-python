import QtQuick 2.15

// Base component for items that can be navigated with Up/Down/Enter keys
Item {
    // Override in derived components
    // Override in derived components
    // Make the component ready for focus
    // Component.onCompleted: {
    //     if (navigable) {
    //         console.log("NavigableItem: Initialized with navigable=true");
    //     }
    // }

    id: navigableItem

    // Navigation properties
    property bool navigable: true
    // Whether this item can be navigated to
    property bool isActiveItem: false
    // Whether this is the currently active item
    property bool visualFocus: activeFocus || isActiveItem
    // Visual state
    property bool highlighted: visualFocus
    property color backgroundColor: highlighted ? ThemeManager.accentColor : ThemeManager.buttonColor
    property color textColor: highlighted ? ThemeManager.focusTextColor : ThemeManager.textColor
    // For sliders and other value adjustments
    property bool isAdjustable: false
    property real adjustmentStep: 0.1

    // Function that will be called when Enter is pressed on this item
    signal clicked()

    // Support for value adjustment (for sliders, etc.)
    function increaseValue() {
    }

    function decreaseValue() {
    }

    // Explicit key handling for this item
    Keys.onReturnPressed: function(event) {
        if (navigable) {
            // console.log("NavigableItem: Return key pressed on item");
            clicked();
            event.accepted = true;
        }
    }
    Keys.onEnterPressed: function(event) {
        if (navigable) {
            // console.log("NavigableItem: Enter key pressed on item");
            clicked();
            event.accepted = true;
        }
    }
    // Handle property changes
    onIsActiveItemChanged: {
        // console.log("NavigableItem: Forcing focus");

        // console.log("NavigableItem: isActiveItem changed to: " + isActiveItem + " for " + (parent ? parent.objectName || "unnamed" : "no parent"));
        if (isActiveItem)
            forceActiveFocus();

    }
    // Handle focused state
    onActiveFocusChanged: {
        // console.log("NavigableItem: activeFocus changed to: " + activeFocus + " for " + (parent ? parent.objectName || "unnamed" : "no parent"));
        if (activeFocus && !isActiveItem)
            isActiveItem = true;

    }

    // Static focus indicator optimized for e-ink
    Rectangle {
        id: focusIndicator

        anchors.fill: parent
        color: ThemeManager.transparentColor
        border.width: parent.visualFocus ? ThemeManager.borderWidth * 2 : 0 // Increased border width
        border.color: ThemeManager.accentColor
        radius: parent.width
        visible: parent.visualFocus
        opacity: 1
    }

}
