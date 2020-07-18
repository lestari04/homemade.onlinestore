<%@page import="control.koneksi"%>
<%@page import="java.sql.*"%>
<h1>Data Master Customer</h1>
<table border="5">
    <form action="CusServlet" method="post" onsubmit="return validasi_inputCustomer(this)">
       <input type="hidden" name="aksi" value="${param.aksi}"/>
       <tr>
           <td>Kode Customer</td> <td>: <input type="text" name="kodecust" value="${param.kd_cust}"/> </td>
       </tr>
       <tr>
           <td>Nama Customer</td> <td>: <input type="text" name="namacust" value="${param.nm_cust}"/> </td>
       </tr>
       <tr>
           <td>Alamat Customer</td> <td>: <input type="text" name="alamat" value="${param.alamat}"/> </td>
       </tr>
       <tr>
           <td>Telepon Customer</td> <td>: <input type="text" name="tlp" onkeypress="return hanyaAngka(event)" value="${param.telpon}"/> </td>
       </tr>
       <tr>
           <td><input type="submit" value="Simpan" class="button"/></td> <td></td>
       </tr>
    </form>
       <td></tr></table><br>
    <form action="" method="post">
        Cari Data Customer : <input type="text" name="cari" value="${param.cari}"/>
        <input type="submit" value="Cari" class="button"/> <br>
    </form>
    <sql:query var="querycustomer" dataSource="${dataSource}">
        SELECT * from customer where kd_cust like '%${param.cari}%' or nm_cust like '%${param.cari}%'
    </sql:query>
    <br><table border="1" width="100%" cellpadding="0" cellspacing="0">
        <tr class="head">
            <td>Kode Customer</td><td>Nama Customer</td><td>Alamat Customer</td><td>Telepon</td><td>Action</td>
        </tr>
    <c:forEach var="rowcust" items="${querycustomer.rowsByIndex}">
        <tr class="isi">
            <td valign='top'>${rowcust[0]}</td>
            <td valign='top'>${rowcust[1]}</td>
            <td valign='top'>${rowcust[2]}</td>
            <td valign='top'>${rowcust[3]}</td>
            <td valign='top'><a href='CusServlet?aksi=HAPUS&kodecust=${rowcust[0]}'> Hapus</a> | <a href='beranda.jsp?halaman=tampilcus&aksi=GANTI&kd_cust=${rowcust[0]}&nm_cust=${rowcust[1]}&alamat=${rowcust[2]}&telpon=${rowcust[3]}'> Edit </a>
            </td>
        </tr>
    </c:forEach>
 </table>

