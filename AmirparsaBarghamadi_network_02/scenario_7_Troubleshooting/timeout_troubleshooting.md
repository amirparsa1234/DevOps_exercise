# عیب‌یابی تایم‌اوت SSH

## علت‌های رایج
- آی‌پی یا پورت اشتباه است
- فایروال پورت را بسته است
- سرور خاموش است یا سرویس SSH بالا نیست
- مشکل مسیر شبکه یا VPN یا NAT وجود دارد
- DNS به آی‌پی اشتباه اشاره می‌کند

## چک‌های سریع
```bash
dig server.example.com +short
nc -zv -w 5 <ip> 22
traceroute <ip>
ssh -o ConnectTimeout=5 user@<ip>
