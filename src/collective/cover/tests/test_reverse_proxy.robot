*** Settings ***

Documentation  https://github.com/collective/collective.cover/issues/59

Resource  cover.robot
Library  Remote  ${PLONE_URL}/RobotRemote

Test Setup  Open SauceLabs test browser
Test Teardown  Run keywords  Report test status  Close all browsers

*** Variables ***

${basic_tile_location}  'collective.cover.basic'
${document_selector}  .ui-draggable .contenttype-document
${file_selector}  .ui-draggable .contenttype-file
${image_selector}  .ui-draggable .contenttype-image
${link_selector}  .ui-draggable .contenttype-link
${tile_selector}  div.tile-container div.tile
${news_item_selector}  .ui-draggable .contenttype-news-item
${news_item_title}  Test news item
${news_item_description}  This news item was created for testing purposes

*** Test cases ***

Test Reverse Proxy
    Enable Autologin as  Site Administrator
    Go to Homepage

    Create Cover  Title  Description  Empty layout
    Click Link  link=Layout

    Add Tile  ${basic_tile_location}
    Save Cover Layout

    Click Link  link=Compose
    Page Should Contain   Please drag&drop some content here to populate the tile.

    Open Browser  http://localhost:${PORT}/VirtualHostBase/http/127.0.0.1:${PORT}/plone/VirtualHostRoot/_vh_subplone/title-1
    Page Should Contain   Please drag&drop some content here to populate the tile.

    Switch Browser  1
    Click Link  link=Layout
    Delete Tile
    Save Cover Layout

    Switch Browser  2
    Close Browser
