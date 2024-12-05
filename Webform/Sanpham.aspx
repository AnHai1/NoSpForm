<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sanpham.aspx.cs" Inherits="QLSP_NoSeparateForm.Sanpham" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Quản lý sản phẩm</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            position: relative;
            min-height: 100vh;
            background: linear-gradient(45deg, #3498db, #2ecc71);
            color: #333;
        }

        #particles-canvas {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 0;
        }

        .bg-pattern {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
            background: linear-gradient(45deg, #23a6d5, #23d5ab);
            overflow: hidden;
        }

        .bg-pattern:before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-image: linear-gradient(rgba(255,255,255,0.1) 1px, transparent 1px), 
                            linear-gradient(90deg, rgba(255,255,255,0.1) 1px, transparent 1px);
            background-size: 30px 30px;
        }

        .network-pattern {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: radial-gradient(rgba(255,255,255,0.2) 1px, transparent 1px);
            background-size: 50px 50px;
        }

        h1 {
            text-align: center;
            color: #ffffff;
            font-weight: 600;
            margin-bottom: 20px;
            position: relative;
            z-index: 1;
            animation: fadeInDown 0.6s ease-out;
        }

        .form-container {
            width: 90%;
            max-width: 1375px;
            margin: 20px auto;
            padding: 20px;
            background: rgba(255, 255, 255, 0.95);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            border-radius: 15px;
            backdrop-filter: blur(10px);
            position: relative;
            z-index: 1;
            transition: all 0.5s ease;
            overflow: hidden;
            cursor: pointer;
        }

        .form-container.collapsed {
            max-height: 60px;
            padding: 15px 35px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .form-container.collapsed table,
        .form-container.collapsed .asp-button {
            display: none;
        }

        .form-container.collapsed::after {
            content: 'Quản lý các sản phẩm';
            font-size: 18px;
            font-weight: bold;
            color: #333;
        }

        .form-container table {
            opacity: 1;
            transition: opacity 0.3s ease;
        }

        @keyframes collapseForm {
            from {
                max-height: 1000px;
                opacity: 1;
            }
            to {
                max-height: 60px;
                opacity: 0.8;
            }
        }

        @keyframes expandForm {
            from {
                max-height: 60px;
                opacity: 0.8;
            }
            to {
                max-height: 1000px;
                opacity: 1;
            }
        }

        /* Your existing styles here with minor modifications */
        .form-container table {
            width: 100%;
        }

        .form-container td {
            padding: 8px;
            vertical-align: top;
        }

        .form-container td label {
            font-weight: bold;
            color: #4a4a4a;
        }

        .form-container input[type="text"],
        .form-container input[type="file"] {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }

        input[type="text" i] {
            padding-block: 1px;
            padding-inline: 2px;
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }

        input[type="button" i],
        input[type="submit" i] {
            padding: 10px 20px;
            border: none;
            color: #fff;
            background: linear-gradient(45deg, #3498db, #2ecc71);
            cursor: pointer;
            font-weight: bold;
            border-radius: 4px;
            margin-right: 10px;
            transition: all 0.3s ease;
        }

        .form-container .asp-button {
            padding: 10px 20px;
            border: none;
            color: #fff;
            background: linear-gradient(45deg, #3498db, #2ecc71);
            cursor: pointer;
            font-weight: bold;
            border-radius: 4px;
            margin-right: 10px;
            transition: all 0.3s ease;
        }

        .form-container .asp-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
        }

        .gridview-container {
            width: 90%;
            max-width: 1415px;
            margin: 20px auto;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            overflow-x: auto; /* Thêm scroll ngang khi cần */
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            backdrop-filter: blur(10px);
            position: relative;
            z-index: 1;
            animation: fadeInUp 0.8s ease-out;
        }
        .gridview-container table {
            width: 100%;
            table-layout: fixed; /* Tất cả các cột có chiều rộng cố định */
            border-collapse: collapse;
        }

        .gridview-container th,
        .gridview-container td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
            color: #4a4a4a;
            word-wrap: break-word; /* Cho phép ngắt dòng trong ô */
        }

        .gridview-container th:nth-child(1),
        .gridview-container td:nth-child(1) {
            width: 2%; /* Cột đầu tiên chiếm 20% chiều rộng */
        }

        .gridview-container th:nth-child(2),
        .gridview-container td:nth-child(2) {
            width: 5%; 
        }

        .gridview-container th:nth-child(3),
        .gridview-container td:nth-child(3) {
            width: 15%; 
        }

        .gridview-container th:nth-child(4),
        .gridview-container td:nth-child(4) {
            width: 10%; 
        }

        .gridview-container th:nth-child(6),
        .gridview-container td:nth-child(6) {
            width: 10%; 
        }

        .gridview-container th:nth-child(7),
        .gridview-container td:nth-child(7) {
            width: 8%; 
        }

        .gridview-container th:nth-child(8),
        .gridview-container td:nth-child(8) {
            width: 12%; 
        }

        .gridview-container th {
            background: linear-gradient(45deg, #3498db, #2ecc71);
            color: #ffffff;
            font-weight: bold;
        }

        .gridview-container tr {
            animation: fadeIn 0.5s ease forwards;
            transition: transform 0.3s ease;
        }

        .gridview-container tr:hover {
            background-color: rgba(241, 248, 255, 0.8);
            transform: translateX(5px);
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes fadeInDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateX(-10px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        @media (max-width: 768px) {
            .form-container,
            .gridview-container {
                width: 95%;
                margin: 10px auto;
                padding: 15px;
            }
        }
    </style>
</head>
<body>
    <div class="bg-pattern">
        <div class="network-pattern"></div>
        <canvas id="particles-canvas"></canvas>
    </div>
    <form id="form1" runat="server">
        <div>
            <div class="form-container">
                <table>
                    <tr>
                        <td><label for="txt_masp">Mã sản phẩm:</label></td>
                        <td><asp:TextBox ID="txt_masp" runat="server" /></td>
                    </tr>
                    <tr>
                        <td><label for="txt_tensp">Tên sản phẩm:</label></td>
                        <td><asp:TextBox ID="txt_tensp" runat="server" /></td>
                    </tr>
                    <tr>
                        <td><label for="txt_hangsx">Hãng sản xuất:</label></td>
                        <td><asp:TextBox ID="txt_hangsx" runat="server" /></td>
                    </tr>
                    <tr>
                        <td><label for="txt_mota">Mô tả:</label></td>
                        <td><asp:TextBox ID="txt_mota" runat="server" TextMode="MultiLine" /></td>
                    </tr>
                    <tr>
                        <td><label for="txt_dongia">Đơn giá:</label></td>
                        <td><asp:TextBox ID="txt_dongia" runat="server" /></td>
                    </tr>
                    <tr>
                        <td><label for="txt_ngaydang">Ngày đăng:</label></td>
                        <td><asp:TextBox ID="txt_ngaydang" runat="server" TextMode="Date" /></td>
                    </tr>
                    <tr>
                        <td><label for="FileUpload1">Hình ảnh:</label></td>
                        <td><asp:FileUpload ID="FileUpload1" runat="server" /></td>
                    </tr>
                </table>
                <asp:Button type="button" ID="btn_Them" CssClass="asp-button" runat="server" Text="Thêm" OnClick="btn_Them_Click" />
                <asp:Button type="button" ID="btn_xoa" CssClass="asp-button" runat="server" Text="Xóa" OnClick="btn_xoa_Click" />
                <asp:Button type="button" ID="btn_nhaplai" CssClass="asp-button" runat="server" Text="Nhập lại" OnClick="btn_nhaplai_Click" /></div>
            </div>

            <div class="gridview-container">
                <asp:GridView ID="gvSanPham" runat="server" AutoGenerateColumns="False" DataKeyNames="Masp" CellPadding="10" 
                    OnRowCancelingEdit="gvSanPham_RowCancelingEdit" 
                    OnRowEditing="gvSanPham_RowEditing" 
                    OnRowUpdating="gvSanPham_RowUpdating">
                    <Columns>
                        <asp:TemplateField>
                            <HeaderTemplate>
                                <asp:CheckBox ID="ck_all" runat="server" AutoPostBack="True" OnCheckedChanged="ck_all_CheckedChanged" />
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="ckb_ma" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Masp" HeaderText="Mã SP" ReadOnly="True" />
                        <asp:BoundField DataField="Tensp" HeaderText="Tên sản phẩm" />
                        <asp:BoundField DataField="Hangsx" HeaderText="Hãng sản xuất" />
                        <asp:BoundField DataField="Mota" HeaderText="Mô tả" />
                        <asp:BoundField DataField="Dongia" HeaderText="Đơn giá" DataFormatString="{0:N0} VNĐ" />
                        <asp:BoundField DataField="Ngaydang" HeaderText="Ngày đăng" DataFormatString="{0:dd/MM/yyyy}" />
                        <asp:TemplateField HeaderText="Hình ảnh">
                            <EditItemTemplate>
                                <asp:FileUpload ID="FileUpload2" runat="server" />
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Image ID="Image1" runat="server" ImageUrl='<%# "~/Images/" + Eval("Hinhanh") %>' Width="100" Height="100" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:CommandField HeaderText="Chức năng" ShowEditButton="True" ButtonType="Button" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </form>
        <script>
        const canvas = document.getElementById('particles-canvas');
        const ctx = canvas.getContext('2d');

        canvas.height = window.innerHeight;
        canvas.width = window.innerWidth;

        let particlesArray;

        const mouse = {
            x: null,
            y: null,
            radius: (canvas.height / 80) * (canvas.width / 80)
        };

        window.addEventListener('mousemove', (event) => {
            mouse.x = event.x;
            mouse.y = event.y;
        });

        class Particle {
            constructor(x, y, directionX, directionY, size, color) {
                this.x = x;
                this.y = y;
                this.directionX = directionX;
                this.directionY = directionY;
                this.size = size;
                this.color = color;
            }

            draw() {
                ctx.beginPath();
                ctx.arc(this.x, this.y, this.size, 0, Math.PI * 2, false);
                ctx.fillStyle = this.color;
                ctx.fill();
            }

            update() {
                if (this.x > canvas.width || this.x < 0) {
                    this.directionX = -this.directionX;
                }
                if (this.y > canvas.height || this.y < 0) {
                    this.directionY = -this.directionY;
                }

                let dx = mouse.x - this.x;
                let dy = mouse.y - this.y;
                let distance = Math.sqrt(dx * dx + dy * dy);

                if (distance < mouse.radius + this.size) {
                    if (mouse.x < this.x && this.x < canvas.width - this.size * 10) {
                        this.x += 10;
                    }
                    if (mouse.x > this.x && this.x > this.size * 10) {
                        this.x -= 10;
                    }
                    if (mouse.y < this.y && this.y < canvas.height - this.size * 10) {
                        this.y += 10;
                    }
                    if (mouse.y > this.y && this.y > this.size * 10) {
                        this.y -= 10;
                    }
                }

                this.x += this.directionX;
                this.y += this.directionY;

                this.draw();
            }
        }

        function init() {
            particlesArray = [];
            let numberOfParticles = (canvas.width * canvas.height) / 5000;

            for (let i = 0; i < numberOfParticles; i++) {
                let size = Math.random() * 5 + 1;
                let x = Math.random() * (innerWidth - size * 2) + size;
                let y = Math.random() * (innerHeight - size * 2) + size;
                let directionX = Math.random() * 5 - 2.5;
                let directionY = Math.random() * 5 - 2.5;
                let color = 'rgba(255, 255, 255, 0.8)';

                particlesArray.push(new Particle(x, y, directionX, directionY, size, color));
            }
        }

        function connect() {
            for (let a = 0; a < particlesArray.length; a++) {
                for (let b = a; b < particlesArray.length; b++) {
                    let distance =
                        (particlesArray[a].x - particlesArray[b].x) *
                        (particlesArray[a].x - particlesArray[b].x) +
                        (particlesArray[a].y - particlesArray[b].y) *
                        (particlesArray[a].y - particlesArray[b].y);

                    if (distance < (canvas.width / 7) * (canvas.height / 7)) {
                        let opacityValue = 1 - distance / 20000;
                        ctx.strokeStyle = `rgba(255, 255, 255, ${opacityValue})`;
                        ctx.lineWidth = 1;
                        ctx.beginPath();
                        ctx.moveTo(particlesArray[a].x, particlesArray[a].y);
                        ctx.lineTo(particlesArray[b].x, particlesArray[b].y);
                        ctx.stroke();
                    }
                }
            }
        }

        function animate() {
            requestAnimationFrame(animate);
            ctx.clearRect(0, 0, innerWidth, innerHeight);

            for (let i = 0; i < particlesArray.length; i++) {
                particlesArray[i].update();
            }
            connect();
        }

        init();
        animate();

        window.addEventListener('resize', () => {
            canvas.width = innerWidth;
            canvas.height = innerHeight;
            mouse.radius = (canvas.height / 80) * (canvas.width / 80);
            init();
        });

        window.addEventListener('mouseout', () => {
            mouse.x = undefined;
            mouse.y = undefined;
        });

        setInterval(() => {
            mouse.x = undefined;
            mouse.y = undefined;
        }, 100);
        // Thêm code JavaScript này vào cuối file, trước thẻ đóng body
        document.querySelector('.form-container').addEventListener('click', function (e) {
            if (e.target === this) {
                this.classList.toggle('collapsed');

                if (this.classList.contains('collapsed')) {
                    this.style.animation = 'collapseForm 0.5s ease forwards';
                } else {
                    this.style.animation = 'expandForm 0.5s ease forwards';
                }
            }
        });

        // Thêm keyframes mới cho animation
        const style = document.createElement('style');
        style.textContent = `
            @keyframes collapseForm {
                0% {
                    max-height: 1000px;
                    transform: scale(1);
                }
                100% {
                    max-height: 60px;
                    transform: scale(0.98);
                }
            }

            @keyframes expandForm {
                0% {
                    max-height: 60px;
                    transform: scale(0.98);
                }
                100% {
                    max-height: 1000px;
                    transform: scale(1);
                }
            }
        `;
        document.head.appendChild(style);
        </script>
</body>
</html>
