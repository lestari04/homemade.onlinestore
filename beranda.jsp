<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<sql:setDataSource var="dataSource"
                   driver="com.mysql.jdbc.Driver"
                   url="jdbc:mysql://localhost:3306/homemade.onlinestore"
                   user="root"password=""/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Homemade.Onlinestore</title>
        <link href="config/stylestr.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="config/setting.js"></script>
        <link href="config/cssTable.css" rel="stylesheet" type="text/css" />
    </head>
    <body>
        <div id="wrap"> 
            <div id="header"><%-- awal header --%>
                <img src="image/logo online.jpg">
                <h1><a>Homemade.Onlinestore</a></h1>
                <h2>Belanja Cerdas Harga Pas</h2>
            </div><%-- akhir dari header --%>
            <div id="menu"><%-- awal dari menu atas --%>
                <ul>
                    <li><a href="beranda.jsp?halaman=home">Home</a></li>
                    <li><a href="about.jsp?halaman=about">About</a></li>
                    <li><a href="indexstr.jsp">Logout</a></li>
                </ul>
            </div><%-- akhir dari menu atas --%>
            <div id="content"><%-- awal dari isi content --%>
                <div class="left"> <%-- awal dari content sebelah kiri web --%>
                    <h2>Master Data</h2>
                    <ul>
                        <li><a href="beranda.jsp?halaman=tampilbrg&aksi=SIMPAN">Data Barang</a></li>
                        <li><a href="beranda.jsp?halaman=tampilcus&aksi=SIMPAN">Data Customer</a></li>
                    </ul>
                    <h2> Transaksi</h2>
                    <ul>
                        <li><a href="beranda.jsp?halaman=pesan"> Transaksi Pemesanan</a></li>
                        <li><a href="beranda.jsp?halaman=jual">Transaksi Penjualan</a></li>
                        <li><a href="beranda.jsp?halaman=returbarang">Retur Barang</a></li>
                    </ul>
                </div><%-- akhir dari content sebelah kiri web --%>
                
                <div class="right"><%-- awal dari content sebelah kanan web --%>
                    <table width="100%">
                        <tr>
                            <td valign="top" width="110%">
                                <div class="text_area" align="justify">
                                <%-- isi dari content sebelah kanan --%>
                                        <c:choose>
                        <c:when test="${param.halaman=='home'}">
                            <%@include file="homestr.jsp" %>
                        </c:when>
                        <c:when test="${param.halaman=='about'}">
                            <%@include file="about.jsp" %>
                        </c:when>
                        <c:when test="${param.halaman=='tampilbrg'}">
                            <%@include file="barang.jsp" %>
                        </c:when>
                        <c:when test="${param.halaman=='tampilcus'}">
                            <%@include file="customer.jsp" %>
                        </c:when>
                        <c:when test="${param.halaman=='pesan'}">
                            <%@include file="pemesanan.jsp" %>
                        </c:when>
                        <c:when test="${param.halaman=='returbarang'}">
                            <%@include file="retur.jsp" %>
                        </c:when>
                        <c:when test="${param.halaman=='logout'}">
                            <%@include file="indexstr.jsp" %>
                        </c:when>
                        <c:otherwise>
                            <%@include file="homesr.jsp" %>
                        </c:otherwise>
                        </c:choose>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
             </div>               
                    <div class="footer"><%-- awal dari content footer web --%>
                        Support by <a href="http://bsi.ac.id/">Junior Programmer
                            Mahasiswa Program Studi Sistem Informasi Akuntansi</a>,<br>
                        Thanks to Layout menu utama menggunakan CSS
                    </div><%-- akhir dari content footer web --%>
                <div style="clear: both;"> </div>
        </div><%--akhir dari halaman web --%>
    
</html>