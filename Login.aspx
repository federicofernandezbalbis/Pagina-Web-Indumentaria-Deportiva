<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Proyecto2.Login" %>

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
    <div class="logo">
      <a href="Home.aspx"><img src="Imagenes/Tiro Libre 3.png" alt="Logo de la tienda" style="width: 100px; height: 100px;"></a>
    </div>
    <nav class="category-bar">
        <div class="lista">
            <ul>
                <li><a href="Register.aspx">Registrarme</a></li>
            </ul>
        </div>
    </nav>
  </header>
  <main>
      <div class="main-login">
          <div class="capa"></div>
          <div class="login">
              <h1>Iniciar Sesión</h1>
              <h2 id="loginMail">Mail:</h2>
              <asp:TextBox ID="txtMail" runat="server" CssClass="txtInputs"></asp:TextBox>
              <asp:Label ID="lblError" runat="server" Text="El mail ingresado no existe" Visible="false" ForeColor="Red"></asp:Label>
              <h2 ID="pass">Contraseña:</h2>
              <asp:TextBox ID="txtClave" type="password" runat="server"  CssClass="txtInputs"></asp:TextBox>
              <asp:Label ID="lblError2" runat="server" Text="La contrseña ingresada es incorrecta" Visible="false" ForeColor="Red"></asp:Label>
              <div class="botones-formulario">
                  <asp:Button ID="btnIniciarSesion" runat="server" Text="INICIAR SESIÓN" OnClick="btnIniciarSesion_Click"/>
              </div>
              <a href="Register.aspx">Registrarse</a>
          </div>
      </div>
  </main>
    </form>
</body>
</html>
