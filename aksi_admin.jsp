package control;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class aksi_admin extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException  {
        response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
        try{
            String aksi =request.getParameter("aksi");
            String user_name = request.getParameter("user_name");
            String nama_lengkap = request.getParameter("nama_lengkap");
            String password = request.getParameter("password");
            String hak_akses = request.getParameter("hak_akses");
            String cari = request.getParameter("cari");
             Class.forName("com.mysql.jdbc.Driver");
                    Connection koneksi=DriverManager.getConnection
                        ("jdbc:mysql://localhost:8080/sewa_sepeda","root","");
               switch (aksi) {
              case "SIMPAN":
                if(user_name.equals("")||nama_lengkap.equals("")||password.equals("")||hak_akses.equals("")){
                    out.println("<script>alert('Gagal...masih ada data yang belum terisi,Silahkan Ulangi!!!')"+
                      "</script><meta http-equiv='refresh' content='1;user.jsp?halaman=admin&aksi=SIMPAN'/>");
                   }
               else {
                        koneksi.createStatement().execute("insert into admin values('"+ user_name + "','" + nama_lengkap + "','" + password + "','" + hak_akses + "')");
                         out.println("<script>alert('Data Admin berhasil Disimpan...!!!')</script>"
                          + "<meta http-equiv='refresh' content='1;user.jsp?halaman=admin&aksi=SIMPAN'/>");
                    }
                   break;
                   case "HAPUS":
                       koneksi.createStatement().execute("delete from admin where user_name='" + user_name + "'");
                       out.println("<script>alert('Data Admin berhasil Dihapus...!!!')</script>"
                                 + "<meta http-equiv='refresh' content='1;user.jsp?halaman=data_admin'/>");
                       break;
                   case "GANTI":
                       koneksi.createStatement().execute("update admin set nama_lengkap='" + nama_lengkap + "', "
                       + "password='" + password + "', hak_akses='" + hak_akses + "' "
                       + "where user_name='" + user_name + "'");
                       out.println("<script>alert('Data Admin berhasil Diubah...!!!')</script>"
                       + "<meta http-equiv='refresh' content='1;user.jsp?halaman=data_admin'/>");
                       break;
                   default:
                       break;
               }
            } catch (ClassNotFoundException | SQLException e){
                out.println("<script>alert('Gagal... Kemungkinan User Name sudah ada, Silahkan Ulangi!!!')</script>"
                + "<meta http-equiv='refresh' content='1;user.jsp?halaman=data_admin'/");
            }        
    }
}
