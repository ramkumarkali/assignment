import re
from collections import Counter

# Define log file path
log_file_path = "access.log"

# Regular expression pattern to parse common log format
log_pattern = re.compile(
    r'(?P<ip>[\d\.]+) - - \[(?P<date>[^\]]+)\] "(?P<method>\S+) (?P<path>\S+) \S+" (?P<status>\d{3}) (?P<size>\d+)'
)

# Initialize counters and containers
total_requests = 0
status_counter = Counter()
page_counter = Counter()
ip_counter = Counter()

with open(log_file_path, 'r') as log_file:
    for line in log_file:
        match = log_pattern.match(line)
        if match:
            total_requests += 1
            ip = match.group("ip")
            status = match.group("status")
            path = match.group("path")

            
            status_counter[status] += 1
            page_counter[path] += 1
            ip_counter[ip] += 1

# Generate report
print("Web Server Log Analysis Report")
print("=" * 40)
print(f"Total requests: {total_requests}")

# Number of 404 errors
print(f"404 Errors: {status_counter.get('404', 0)}")

# Most requested pages
print("\nTop 5 Most Requested Pages:")
for page, count in page_counter.most_common(5):
    print(f"{page}: {count} requests")

# IP addresses with the most requests
print("\nTop 5 IPs with Most Requests:")
for ip, count in ip_counter.most_common(5):
    print(f"{ip}: {count} requests")
