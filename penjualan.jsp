<%@page import="java.sql.ResultSet"%>
<%@page import="control.koneksi"%>
<%@page import="model.pemesanan"%>
<%@page import="java.util.Date"%>
<%@include file="config/autokode.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% java.util.Date waktu = new java.util.Date();
    int tanggal = waktu.getDate();
    int tahun = waktu.getYear() + 1900;
    int bulan = waktu.getMonth() + 1;
    String tgl = tahun + "-" + bulan + "-" + tanggal;
    pemesanan pemesanan = new pemesanan();
    ResultSet qrypesan = null;
    String no = null;
    String sql = "SELECT MAX(RIGHT(no_jual,6)) FROM jual";
    koneksi kon = new koneksi();
    ResultSet rs = kon.stmt.executeQuery(sql);
    if (!rs.next()){
        no = "JU000001";
    } else {
        int urutanBaru = rs.getInt(1) + 1;
        String kode = String.valueOf(urutanBaru);
        int panjangKode = kode.length();
        for (int i = panjangKode; i < 6; i++) {
        kode = "0" + kode;
    }
        no= "JU" + kode;
    }
    String non = "NT" + no.substring(2);
    %>
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title> Transaksi Penjualan</title>
        </head>
        <body>
            <h1>Transaksi Penjualan Store</h1></br>
            <table border="0">
                <form action="penjualanServlet" method="post">
                    <h2>Data Jual</h2>
                    <tr>
                        <td>No Jual</td> 
                        <td>: <input type="text" name="nojual" value="<%=no%>" readonly/></td>
                    </tr>
                    <tr>
                        <td>No Nota</td> 
                        <td>: <input type="text" name="non" value="<%=non%>" readonly/></td>
                    </tr>
                    <tr>
                        <td>Tanggal Jual</td>
                        <td>: <input type="text" name="tgl" value =<%= tgl%> ></td>
                    </tr>
                    <tr>
                        <td>Nomor Pesan</td>
                        <td>: <select name="nopes" onchange="showPesan(this.value);">
                                <option value="-1">Pilih Nomor Pesan</option>
                                <%
                                    qrypesan = kon.stmt.executeQuery("SELECT no_pesan FROM pemesanan where not exists"
                                    + "(select * from jual where pemesanan.no_pesan=jual.no_pesan)");
                                    while (qrypesan.next()) {
                                        pemesanan.setNopesan(qrypesan.getString("no_pesan"));
                                        %>
                                <option value="<%=pemesanan.getNopesan()%>"><%=pemesanan.getNopesan()%></option>
                                <% } %>
                            </select></td>
                    </tr>
                    <input type="hidden" name="nopes" id="pesan" value="${param.cari}">
                    <tr>
                        <td><input type="submit" name="aksi" value="Tambah"/></br>
                    </tr>
            </table>
                    <%
                        sql = "select * from sementara";
                        rs = kon.stmt.executeQuery(sql);
                        %>
                        <br/><br/>
                        <h3>Data Barang</h3>
                        <table border="2">
                            <tr>
                                <th>Nama Barang</th>
                                <th>Kode Barang</th>
                                <th>Quantity</th>
                                <th>Subtotal</th>
                                <th>Aksi</th>
                            </tr> 
                            <% if (!rs.next()) { %>
                            <tr>
                                <td clospan="5">Data masih kosong</td> 
                            </tr>
                            <% } %>
                            <% rs.beforeFirst(); %>
                            <% while (rs.next()) {%>
                            <tr>
                                <td><%= rs.getString(1)%></td>
                                <td><%= rs.getString(2)%></td>
                                <td><%= rs.getString(3)%></td>
                                <td><%= rs.getString(4)%></td>
                                <td>
                                    <a href="penjualanServlet?aksi=Delete&kodebarang=<%= rs.getString(2)%>">HAPUS</a>
                                </td>
                            </tr>
                            <% }%>
                        </table>
                        <table>
                            <sql:query var="ttl" dataSource="${dataSource}">
                                SELECT SUM(quantity) AS ttl_D, SUM(subtotal) AS ttl_K FROM sementara
                            </sql:query>
                            <c:forEach var='ttlDK'items='${ttl.rowsByIndex}'><br>
                                <table border="0">
                                    <tr>
                                        <td>Total Jumlah Barang yang Di Jual</td>
                                        <td>: <input type="text" readonly="readonly" name="total" size="1" value="${ttlDK[0]}"></td>
                                    </tr>
                                    <tr>
                                        <td>Total Bayar</td>
                                        <td>: <input type="text" readonly="readonly" name="tobay" value="${ttlDK[1]}"></td>
                                    </tr>
                                    </c:forEach>
                                    <tr><td><input type="submit" value="Simpan" name="aksi"> <input type="reset" value="cancel"></td></tr>
                                </table>
                            </body>
                            </html>
    