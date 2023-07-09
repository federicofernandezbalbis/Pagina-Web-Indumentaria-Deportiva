<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Proyecto2.Register" %>

<!DOCTYPE html>

<html>
<head>
        <title>Tiro Libre: Tu lugar de indumentaria deportiva</title>
  <link rel="stylesheet" type="text/css" href="CSS1.css">
  <link rel="stylesheet" href="CSS/Bootstrap.css" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Audiowide&family=Graduate&display=swap" rel="stylesheet">
</head>
<body>
    <form id="form1" runat="server">
  <header>
 <a href="Home.aspx"><img src="Imagenes/Tiro Libre 3.png" alt="Logo de la tienda" style="width:100px; height:100px;"></a>
    <nav class="category-bar">
        <div class="lista">
            <ul>
                <li><a href="Login.aspx">Iniciar Sesión</a></li>
            </ul>
        </div>
    </nav>
  </header>
  <main>
      <div class="main-login">
      <div class="capa"></div>
          <div class="login">
              <div class="register-box">
                  <div class="auxRegister">
                      <h2 id="nombre">Nombre:</h2>
                      <asp:TextBox ID="txtNombre" runat="server" CssClass="txtInputs" ValidationGroup="Grupo1" MaxLength="50"></asp:TextBox>
                      <asp:RequiredFieldValidator ID="RFVNombre" runat="server" ControlToValidate="txtNombre" ForeColor="Red" CssClass="RFV-Size" Font-Size="XX-Large" ValidationGroup="Grupo1">*</asp:RequiredFieldValidator>
                  </div>
                  <div class="auxRegister">
                      <h2 id="apellido">Apellido:</h2>
                      <asp:TextBox ID="txtApellido" runat="server" CssClass="txtInputs" ValidationGroup="Grupo1" MaxLength="50"></asp:TextBox>
                      <asp:RequiredFieldValidator ID="RFVApellido" runat="server" ControlToValidate="txtApellido" ForeColor="Red" CssClass="RFV-Size" ValidationGroup="Grupo1">*</asp:RequiredFieldValidator>
                  </div>
              </div>
              <div class="register-box">
                  <div class="auxRegister">
                      <h2 id="nombreUsuario">Nombre de usuario:</h2>
                      <asp:TextBox ID="txtNombreUsuario" runat="server" CssClass="txtInputs" ValidationGroup="Grupo1" MaxLength="30"></asp:TextBox>
                      <asp:RequiredFieldValidator ID="RFVnombreUsuario" runat="server" ControlToValidate="txtNombreUsuario" ForeColor="Red" CssClass="RFV-Size" Font-Size="XX-Large" ValidationGroup="Grupo1">*</asp:RequiredFieldValidator>
                      <asp:Label ID="lblNombreUsuario" runat="server" ForeColor="Red" Text="EL NOMBRE DE USUARIO INGRESADO ESTÁ EN USO" Visible="False"></asp:Label>
                  </div>
                  <div class="auxRegister">
                      <h2 id="dni">DNI:</h2>
                      <asp:TextBox ID="txtDNI" runat="server" CssClass="txtInputs" ValidationGroup="Grupo1" MaxLength="10" TextMode="Number"></asp:TextBox>
                      <asp:RequiredFieldValidator ID="RFVDni" runat="server" ControlToValidate="txtDNI" ForeColor="Red" CssClass="RFV-Size" Font-Size="XX-Large" ValidationGroup="Grupo1">*</asp:RequiredFieldValidator>
                      <asp:Label ID="lblDNI" runat="server" ForeColor="Red" Text="EL DNI INGRESADO YA ESTÁ EN USO" Visible="False"></asp:Label>
                  </div>
              </div>
              <h2 id="direccion">Dirección:</h2>
              <asp:TextBox ID="txtDireccion" runat="server" CssClass="txtInputs" ValidationGroup="Grupo1" MaxLength="70"></asp:TextBox>
              <asp:RequiredFieldValidator ID="RFVDireccion" runat="server" ControlToValidate="txtDireccion" ForeColor="Red" CssClass="RFV-Size" Font-Size="XX-Large" ValidationGroup="Grupo1">*</asp:RequiredFieldValidator>
              <div class="register-box">
                  <div class="auxRegister">
                      <h2 id="localidad">Localidad:</h2>
                      <asp:TextBox ID="txtLocalidad" runat="server" CssClass="txtInputs" ValidationGroup="Grupo1" MaxLength="50"></asp:TextBox>
                      <asp:RequiredFieldValidator ID="RFVLocalidad" runat="server" ControlToValidate="txtLocalidad" ForeColor="Red" CssClass="RFV-Size" Font-Size="XX-Large" ValidationGroup="Grupo1">*</asp:RequiredFieldValidator>
                  </div>
                  <div class="auxRegister">
                      <h2 id="provincia">Provincia:</h2>
                      <asp:DropDownList ID="ddlProvincias" runat="server" ValidationGroup="Grupo1">
                          <asp:ListItem>Buenos Aires</asp:ListItem>
                          <asp:ListItem>Catamarca</asp:ListItem>
                          <asp:ListItem>Chaco</asp:ListItem>
                          <asp:ListItem>Chubut</asp:ListItem>
                          <asp:ListItem>Córdoba</asp:ListItem>
                          <asp:ListItem>Corrientes</asp:ListItem>
                          <asp:ListItem>Entre Ríos</asp:ListItem>
                          <asp:ListItem>Formosa</asp:ListItem>
                          <asp:ListItem>Jujuy</asp:ListItem>
                          <asp:ListItem>La Pampa</asp:ListItem>
                          <asp:ListItem>La Rioja</asp:ListItem>
                          <asp:ListItem>Mendoza</asp:ListItem>
                          <asp:ListItem>Misiones</asp:ListItem>
                          <asp:ListItem>Neuquén</asp:ListItem>
                          <asp:ListItem>Río Negro</asp:ListItem>
                          <asp:ListItem>Salta</asp:ListItem>
                          <asp:ListItem>San Juan</asp:ListItem>
                          <asp:ListItem>San Luis</asp:ListItem>
                          <asp:ListItem>Santa Cruz</asp:ListItem>
                          <asp:ListItem>Sante Fe</asp:ListItem>
                          <asp:ListItem>Santiago del Estero</asp:ListItem>
                          <asp:ListItem>Tierra del Fuego</asp:ListItem>
                          <asp:ListItem>Tucumán</asp:ListItem>
                      </asp:DropDownList>
                      <asp:RequiredFieldValidator ID="RFVProvincia" runat="server" ControlToValidate="ddlProvincias" ForeColor="Red" CssClass="RFV-Size" Font-Size="XX-Large" ValidationGroup="Grupo1">*</asp:RequiredFieldValidator>
                  </div>
              </div>
              <h2 id="email">Email:</h2>
              <asp:TextBox ID="txtEmail" runat="server" CssClass="txtInputs" ValidationGroup="Grupo1" MaxLength="100" TextMode="Email" ForeColor="Black">ejemplo@gmail.com</asp:TextBox>
              <asp:RequiredFieldValidator ID="RFVMail" runat="server" ControlToValidate="txtEmail" ForeColor="Red" CssClass="RFV-Size" ValidationGroup="Grupo1">*</asp:RequiredFieldValidator>
              <asp:Label ID="lblMail" runat="server" ForeColor="Red" Text="EL MAIL INGRESADO YA ESTÁ EN USO" Visible="False"></asp:Label>
              <div class="register-box">
                  <div class="auxRegister">
                      <h2 id="pass">Contraseña:</h2>
                      <asp:TextBox ID="txtPass" runat="server" CssClass="txtInputs" ValidationGroup="Grupo1" MaxLength="20" TextMode="Password"></asp:TextBox>
                      <asp:RequiredFieldValidator ID="RFVContraseña" runat="server" ControlToValidate="txtPass" ForeColor="Red" CssClass="RFV-Size" ValidationGroup="Grupo1">*</asp:RequiredFieldValidator>
                  </div>
                  <div class="auxRegister">
                      <h2 id="repetirPass">Repetir Contraseña:</h2>
                      <asp:TextBox ID="txtRepetirContraseña" runat="server" CssClass="txtInputs" ValidationGroup="Grupo1" MaxLength="20" TextMode="Password"></asp:TextBox>
                      <asp:RequiredFieldValidator ID="RFVrepetirContrseña" runat="server" ControlToValidate="txtRepetirContraseña" ForeColor="Red" CssClass="RFV-Size" Font-Size="XX-Large" ValidationGroup="Grupo1">*</asp:RequiredFieldValidator>
                      <asp:CompareValidator ID="cmpValidatorContraseña" runat="server" ControlToCompare="txtPass" ControlToValidate="txtRepetirContraseña" ForeColor="Red">LAS CONTRASEÑAS NO COINCIDEN</asp:CompareValidator>
                  </div>
              </div>
              <div class="register-box">
                  <div class="auxRegister">
                      <h2 id="telefono">Teléfono:</h2>
                      <asp:TextBox ID="txtTelefono" runat="server" CssClass="txtInputs" ValidationGroup="Grupo1" MaxLength="20" TextMode="Number"></asp:TextBox>
                      <br />
                      <asp:RequiredFieldValidator ID="RFVTelefono" runat="server" ControlToValidate="txtTelefono" ForeColor="Red" CssClass="RFV-Size" ValidationGroup="Grupo1">*</asp:RequiredFieldValidator>
                  </div>
                  <div class="auxRegister">
                      <h2 id="fechaNac">Fecha de Nacimiento:</h2>
                      <asp:TextBox ID="txtFecha" runat="server" type="datetime-local" CssClass="txtInputs" ValidationGroup="Grupo1"></asp:TextBox>
                      <br />
                      <asp:RequiredFieldValidator ID="RFVFecha" runat="server" ControlToValidate="txtFecha" CssClass="RFV-Size" ForeColor="Red" ValidationGroup="Grupo1">*</asp:RequiredFieldValidator>
                      <br />
                  </div>
              </div>
              <div class="botones-formulario">
                  <asp:Button ID="btnRegister" runat="server" Text="REGISTRARSE" OnClick="btnRegister_Click" ValidationGroup="Grupo1" />
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  <asp:Label ID="lblAviso" runat="server" Text="USUARIO REGISTRADO!" Visible="False"></asp:Label>
              </div>
              <div class="redirect">
                  <p>¿Ya tenés una cuenta?</p>
                  <a href="Login.aspx" style="font-weight:800">Iniciar Sesión</a>
              </div>
          </div>
      </div>
  </main>
    </form>
</body>
</html>
