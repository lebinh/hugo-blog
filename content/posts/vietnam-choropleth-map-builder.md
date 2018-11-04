---
title: "Vietnam Choropleth Map Builder"
date: 2018-11-04T23:59:00+11:00
---

Nói ngắn gọn là mình đã tạo một công cụ để vẽ bản đồ choropleth của Việt Nam ở đây — [https://thisisbinh.me/vietnam-choropleth-builder/](https://thisisbinh.me/vietnam-choropleth-builder/)

Đọc tiếp để xem một vài ví dụ được tạo bằng công cụ này hoặc click liên kết trên và bắt tay vào tạo một bản đồ theo ý bạn.

[<img src="per-capita-income.png">](http://bit.ly/2SJRuG7)

_Tất cả bản đồ trong bài này đều dẫn tới trang tạo ra nó cùng dữ liệu và cấu hình. Bạn có thể click bất kỳ bản đồ nào để xem cách nó được tạo ra và chỉnh sửa nó._

## Why?

Để có được bản đồ trong [post trước](https://thisisbinh.me/posts/vietnam-choropleth-map/) mình đã phải mất rất nhiều thời gian làm theo một hướng dẫn dài gồm nhiều công đoạn và thao tác. Điều đó có thể tốt và quan trọng cho việc học hỏi và tìm hiểu, nhưng không phải ai cũng cần biết tất cả như vậy. Đôi khi cái mà phần lớn mọi người cần chỉ là một công cụ đơn giản để vẽ ra một bản đồ đẹp.

Quan trọng hơn, mình làm vì mong muốn thấy được nhiều visualization tốt về Việt Nam hơn trong báo chí, tài liệu, hay sách vở. Và choropleth map có thể là một visualization rất đẹp khi được sử dụng đúng chỗ.

[<img src="population-density.png">](http://bit.ly/2AJZ3p0)

## How?

Phần lớn công việc đã được dọn cỗ sẵn nhờ project [Vega](https://vega.github.io/), hay chính xác hơn là Vega-Lite. Mình biết tới Vega lần đầu khi còn làm ở [Arimo](https://arimo.com/), và hoàn toàn bị blown away bởi nó. Vega là một cách nhìn hoàn toàn khác về visualization — *a visualization grammar*. Thay vì tạo ra một visualization tuần tự theo các bước hay các câu lệnh, ta viết một “miêu tả” của nó, thể hiện nguồn dữ liệu, tương quan của nó với hình dáng, màu sắc, hay các tương tác có thể. Miêu tả này đơn giản là một JSON document, và nhờ vậy có thể dễ dàng sinh ra một cách tự động bằng các chương trình khác, giúp cho việc tạo ra các visualization tương tự nhau một cách đơn giản nhanh chóng.

[Vega-Lite](https://vega.github.io/vega-lite/) — phiên bản rút gọn của Vega — có hỗ trợ sẵn cho việc render một file TopoJSON thành bản đồ. Việc chính của mình chỉ là tạo một web app đơn giản để cho bạn một vài lựa chọn và sinh ra “miêu tả” tương ứng từ đó, Vega sẽ lo phần vẽ bản đồ còn lại.

[<img src="hospital-beds.png">](http://bit.ly/2ALucsx)

## Vài ví dụ khác

### Bản đồ không cần số liệu

Cách đơn giản nhất để tạo bản đồ là liệt kê tên các địa phương mà bạn muốn highlight vào khung “Số liệu”. Trong ví dụ này, ta có thể tạo ra một bản đồ thể hiện các tỉnh Bắc Trung Bộ chỉ bằng cách liệt kê tên các địa phương này.

[<img src="bac-trung-bo.png">](http://bit.ly/2JDhA9F)

_Phần chú thích rõ ràng cần phải được sửa trong trường hợp này_ 😅

### Hay thậm chí không cần gì — making map out of nothing

Thậm chí, trong trường hợp đặc biệt, ta có thể tạo ra bản đồ “programatically” bằng cách sử dụng _Biểu thức biến đổi giá trị_. Đây là một biểu thức theo định dạng của [Vega expressions](https://vega.github.io/vega/docs/expressions/) và có thể dùng để thay đổi dữ liệu của bản đồ. Trong ví dụ này, giá trị của các tỉnh thành, _datum.value_, được tính từ việc xét xem tên của chúng, _datum.id_, có chữ “Quảng” trong đó hay không.

```javascript
indexof(lower(datum.id), "quảng") == -1 ? "không" : "có"
```
 
[<img src="quang-in-name.png">](http://bit.ly/2RvZrx9)

Vậy thôi, hi vọng phần nào nhờ đây mình có thể thấy được nhiều choropleth map của Việt Nam hơn!
