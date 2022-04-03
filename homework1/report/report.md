# گزارش کار تمرین ۱ طراحی سیستم‌های دیجیتال
> علیرضا حبیب‌زاده `99109393`

## طراحی JK-flipflop
برای طراحی این قطعه که قطعه‌ی پایه‌ای مدارمان است، از روش توصیف Behavioral استفاده می‌کنیم. برای این کار فایلی با عنوان دلخواه مثلا `JKFF.v` می‌سازیم. سپس
در آن کد زیر را قرار می‌دهیم.
‍
```verilog
module JKFF(q, j, k, clk, reset);

output q;
input j, k, clk, reset;
reg q;

always @(posedge reset or negedge clk)
	if (reset)
		q = 1'b0;
	else
		if (j && k)
			q = ~q;
		else if (j && ~k)
			q = 1'b1;
		else if (k && ~j)
			q = 1'b0;
		// else do nothing (j = k = 0)
endmodule
```

در این کد رفتار قطعه به ازای حالت‌های مختلف `j` و‍ ‍`k` و همچنین `reset` توصیف شده است. پس از این که این کد به درستی در نرم‌افزار کامپایل شد به قسمت بعد می‌رویم.

## طراحی T-flipflop
برای طراحی این قطعه کافی است از حالت `j = k = 1` در همان فلیپ‌فلاپ JK استفاده کنیم. پس کافی است یک رجیستر ثابت 1 تعریف کنیم و آن را به ورودی‌های یک instance از فلیپ‌فلاپ JK که در بخش قبل طراحی کردیم بدهیم.
```verilog
module TFF(q, clk, reset);

output q;
input clk, reset;
reg t = 1'b1;

JKFF jkff0(q, t, t, clk, reset);

endmodule
```

## طراحی شمارنده
حال مطابق تصویر زیر module ‍‍شمارنده‌مان را پیاده می‌کنیم. برای این کار ۵ instance از فلیپ‌فلاپ T که پیشتر طراحی کردیم لازم است. 

![Counter2](https://user-images.githubusercontent.com/73132146/161432713-e275b355-e380-4ffe-9f5e-c8ab5e0da3ad.gif)
