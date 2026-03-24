*** Settings ***
Library         SeleniumLibrary

*** Variables ***
${browser}      chrome
${URL}          https://www.saucedemo.com/
${username}     standard_user
${password}     secret_sauce
${wrong_username}   username
${wrong_password}   password
${locked_user}    locked_out_user

*** Test Cases ***
#Caso de prueba hecho en clase
TC_000_Login_con_Credenciales_Validas
    Open Browser    ${None}    ${browser}
    Go To           ${URL}
    Input Text      id=user-name    ${username}
    Input Password  id=password     ${password}
    Click Button    id=login-button
    Page Should Contain    Products
    [Teardown]    Close Browser

#10 Casos de prueba de tarea
TC_001_Login_con_Credenciales_Invalidas
    Open Browser    ${URL}    ${browser}
    Input Text      id=user-name    ${wrong_username}
    Input Password  id=password     ${wrong_password}
    Click Button    id=login-button
    Element Should Contain    css=h3[data-test="error"]    Epic sadface: Username and password do not match any user in this service
    [Teardown]    Close Browser

TC_002_Login_Usuario_Bloqueado
    Open Browser    ${URL}    ${browser}
    Input Text      id=user-name    ${locked_user}
    Input Password  id=password     ${password}
    Click Button    id=login-button
    Element Should Contain           css=h3[data-test="error"]    Epic sadface: Sorry, this user has been locked out.
    [Teardown]    Close Browser

TC_003_Agregar_Producto_Al_Carrito
    Open Browser    ${URL}    ${browser}
    Input Text      id=user-name    ${username}
    Input Password  id=password     ${password}
    Click Button    id=login-button
    Click Element    id=item_4_title_link
    Click Button     id=add-to-cart
    Element Text Should Be    css=.shopping_cart_badge    1
    [Teardown]    Close Browser

TC_004_Ordenar_Productos_Precio_Bajo_A_Alto_
    Open Browser    ${URL}    ${browser}
    Input Text      id=user-name    ${username}
    Input Password  id=password     ${password}
    Click Button    id=login-button
    Select From List By Value    css=[data-test="product-sort-container"]    lohi
    ${first_item}=    Get Text    xpath=(//div[@class="inventory_item_name "])[1]
    Should Be Equal As Strings    ${first_item}    Sauce Labs Onesie
    [Teardown]    Close Browser

TC_005_Eliminar_Producto_Del_Carrito
    Open Browser    ${URL}    ${browser}
    Input Text      id=user-name    ${username}
    Input Password  id=password     ${password}
    Click Button    id=login-button
    Click Button    id=add-to-cart-sauce-labs-backpack
    Click Link      class=shopping_cart_link
    Click Button    id=remove-sauce-labs-backpack
    Page Should Not Contain Element    css=.shopping_cart_badge
    [Teardown]    Close Browser