
        let requestIconButton = document.getElementById("requestIconButton");
if (requestIconButton) {
  requestIconButton.addEventListener('click', (event) => {
    event.preventDefault()
    let infoBox = document.querySelector(".app-info-box")
    let smallInfoBox = document.getElementById("addAppForm")
    addClass(infoBox, "app-info-box-hide")
    removeClass(smallInfoBox, "hide-element")
    addClass(smallInfoBox, "show-element")
  });
}

window.onload = function() {
  resizeCards();
};

// Event - Click - then convert category to a tag
onClick(getElement("searchbar-dropdown-category", true), (event)=> {
  if (event.target !== event.currentTarget && event.target.nodeName !== "UL") {
    convertCategoryToTag(event.target);
  }
});

// Event - Click - then show category dropdown
onClick(getElement("category-search-button", true), () => {
  toggleOff(getElement("autocomplete", true));
  toggle(getElement("category", true));
});

// Event - Change - then show autocomplete dropdown
onClick(getElement("search-input", true), (event)=> {
  toggleOff(getElement("category", true));
  toggle(getElement("autocomplete", true));
  compareInput(event.target.value, generateDummyDataForAutocomplete());
});

/**
 * Resize cards with class 'final-box' to
 * fully expand to the container
 */ 
function resizeCards() {
  let cards = getElement("final-box");
  if (cards.length !== 0) {
    for (let c of cards) {
      c.style.maxWidth = null;
    }
    let newMaxWidth = cards[0].offsetWidth;
    for (let c of cards) {
      c.style.maxWidth = `${newMaxWidth}px`;
    }      
  }
}

/**
 * Grabs an element with the given class or id and returns
 * that element or those elements
 * @params string, boolean, boolean
 * @returns node or array of nodes
 */ 
function getElement(sel, firstChild = false, id = false) {
  if (sel && id) return document.getElementById(sel);
  else if (sel && firstChild) return document.getElementsByClassName(sel)[0];
  else if (sel && !firstChild) return document.getElementsByClassName(sel);
  else return null;
}

/**
 * Generates temporary data for the autocomplete
 * searchbar which will be used as values
 * for list items
 * @returns array
 */
function generateDummyDataForAutocomplete() {
  let appList = [];
  for (let i = 0; i < 10; i++) {
    let name = `App ${i}`
    let district = `Demo District Library ${i}`
    let app = {
      "name"     :name,
      "district" :district,
      "tag"      :"Productivity",
    };
    appList.push(app);
  }
  return appList;
}

/**
 * Checks if input matches the values inside an array, and if
 * a match is found, then return those values
 * @params string, array
 * @returns array
 */
function compareInput(input, items) {
  return items.filter(item => item.name.toLowerCase().trim().includes(input));
}

/**
 * Converts a category list item into a category tag which
 * is then attached to the tags container on
 * the dashboard page
 */
function convertCategoryToTag(category) {
  if (category) {
    console.log(category);
    let tag = document.createElement("span");
    addClass(tag, "tag-attached close-tag");
    let closeTag = document.createElement("svg");
    closeTag.innerHTML = CLOSE_TAG;
    let cloneCategory = category.cloneNode(true);
    insertElementsToParent(tag, [cloneCategory.childNodes[0], cloneCategory.childNodes[2], closeTag]);
    insertElementsToParent(getElement("tags-container", true), [tag]);
  }
}

/**
 * Insert elements to a parent node 
 * by iterating through a given array of nodes
 * @params node, array
 */
function insertElementsToParent(parentElement, childrenElements) { 
  for (e of childrenElements) {
    parentElement.appendChild(e);
  }
}

/**
 * Toggles an element to either show or hide
 * @params node
 */
function toggle(ele) {
  if (hasClass(ele, "hide-element")) {
    removeClass(ele, "hide-element"); 
    addClass(ele, "show-element");  
  } else {
    removeClass(ele, "show-element"); 
    addClass(ele, "hide-element");
  }
}

/**
 * Toggles an element on to display the element
 * @params node
 */
function toggleOn(ele) {
  if (hasClass(ele, "hide-element")) {
    removeClass(ele, "hide-element"); 
    addClass(ele, "show-element");  
  }
}

/**
 * Toggles an element off to hide the element
 * @params node
 */
function toggleOff(ele) {
  if (hasClass(ele, "show-element")) {
    removeClass(ele, "show-element"); 
    addClass(ele, "hide-element");
  }
}

/**
 * Helper function that checks for change events on
 * an element and passes an appropriate function
 * @params node, function
 */
function onChange(ele, action) {
  if (ele) {
    ele.addEventListener('change', (event) => {
      event.preventDefault();
      event.stopPropagation();
      action(event);
    });
  }
}

/**
 * Helper function that checks for click events on
 * an element and passes an appropriate function
 * @params node, function
 */
function onClick(ele, action) {
  if (ele) {
    ele.addEventListener('click', (event) => {
      event.preventDefault();
      event.stopPropagation();
      action(event);
    });
  }
}

/**
 * Checks if an element has a given class
 * @params node, string
 * @returns boolean
 */
function hasClass(ele,cls) {
  return !!ele.className.match(new RegExp('(\\s|^)'+cls+'(\\s|$)'));
}

/**
 * Adds a class to an element
 * @params node, string
 */
function addClass(ele,cls) {
  if (!hasClass(ele,cls)) ele.className += " "+cls;
}

/**
 * Removes a class from an element
 * @params node, string
 */
function removeClass(ele,cls) {
  if (hasClass(ele,cls)) {
    var reg = new RegExp('(\\s|^)'+cls+'(\\s|$)');
    ele.className=ele.className.replace(reg,' ');
  }
}

const CLOSE_TAG = '<svg class="svg-inline--fa fa-times fa-w-12" aria-hidden="true" data-prefix="fal" data-icon="times" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 384 512" data-fa-i2svg=""><path fill="currentColor" d="M217.5 256l137.2-137.2c4.7-4.7 4.7-12.3 0-17l-8.5-8.5c-4.7-4.7-12.3-4.7-17 0L192 230.5 54.8 93.4c-4.7-4.7-12.3-4.7-17 0l-8.5 8.5c-4.7 4.7-4.7 12.3 0 17L166.5 256 29.4 393.2c-4.7 4.7-4.7 12.3 0 17l8.5 8.5c4.7 4.7 12.3 4.7 17 0L192 281.5l137.2 137.2c4.7 4.7 12.3 4.7 17 0l8.5-8.5c4.7-4.7 4.7-12.3 0-17L217.5 256z"></path></svg>';
