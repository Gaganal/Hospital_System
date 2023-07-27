<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<%@page import="com.entity.Doctor"%>
<%@page import="com.dao.DoctorDao"%>
<%@page import="com.entity.Appointment"%>
<%@page import="java.util.List"%>
<%@page import="com.db.DBConnect"%>
<%@page import="com.dao.AppointmentDAO"%>
<%@page import="com.doctor.servlet.DoctorLogin"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<style type="text/css">
.paint-card {
	box-shadow: 0 0 10px 0 rgba(0, 0, 0, 0.3);
}
</style>
<%@include file="../component/allcss.jsp"%>

</head>

<body>
	<c:if test="${empty doctObj }">
		<c:redirect url="../doctor_login.jsp"></c:redirect>

	</c:if>


	<%@include file="navbar.jsp"%>
	<div class="container p-3">
		<div class="row">
			<div class="col-md-12">
				<div class="card paint-card">
					<div class="card-body">
						<p class="fs-3 text-center">Patient Details</p>

						<c:if test="${not empty errorMsg }">
							<p class="fs-4 text-center text-danger">${errorMsg}</p>
							<c:remove var="errorMsg" scope="session" />
						</c:if>
						<c:if test="${not empty succMsg }">
							<p class="fs-4 text-center text-info">${succMsg}</p>
							<c:remove var="succMsg" scope="session" />
						</c:if>


						<table class="table">
							<thead>
								<tr>
									<th scope="col">Full Name</th>
									<th scope="col">Gender</th>
									<th scope="col">Age</th>
									<th scope="col">Appointment</th>
									<th scope="col">Email</th>
									<th scope="col">Mob No</th>
									<th scope="col">Diseases</th>
									<th scope="col">Doctor Name</th>
									<th scope="col">Address</th>
									<th scope="col">Status</th>
								</tr>
							</thead>
							<tbody>


								<%
									Doctor d = (Doctor) session.getAttribute("doctObj");
									AppointmentDAO dao = new AppointmentDAO(DBConnect.getConn());
									DoctorDao dao2 = new DoctorDao(DBConnect.getConn());
									List<Appointment> list = dao.getAppointmentByDoctorLogin(d.getId());
									for (Appointment ap : list) {
										/* Doctor d = dao2.getDoctorById(ap.getDoctorId()); */
								%>
								<tr>
									<th><%=ap.getFullName()%></th>
									<td><%=ap.getGender()%></td>
									<td><%=ap.getAge()%></td>
									<td><%=ap.getAppointmentDate()%></td>
									<td><%=ap.getEmail()%></td>
									<td><%=ap.getPhNo()%></td>
									<td><%=ap.getDiseases()%></td>
									<td><%=d.getFullName()%></td>
									<td><%=ap.getAdress()%></td>
									<td><%=ap.getStatus()%></td>
									<td>
									<%
									if("Pending".equals(ap.getStatus())){%>
										<a href="comment.jsp?id=<%=ap.getId() %>" 
										class="btn btn-success btn-sm">Comment</a>
                                        
									<%}else{%>
										<a href="#" 
												class="btn btn-success btn-sm disabled">Comment</a>
										
									<%}
									%>
									</td>
								</tr>
								<%
									}
								%>


							</tbody>
						</table>

					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>