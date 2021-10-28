#include <iostream>
#include <mutex>
#include <string>
#include <thread>

std::mutex msg_mutex;
std::string msg_input;

void read()
{
    while (true)
    {
        std::string sin;
        std::cin >> sin;
        std::lock_guard<std::mutex> lock{msg_mutex};

        msg_input = sin;

        std::string get_data = "cd cache/www && wget --page-requisites --adjust-extension --span-hosts --convert-links --quiet --recursive --no-cache" + msg_input;
        const char *command = get_data.c_str();
        std::system(command);
    }
}

int main()
{
    std::thread reader(read);

    reader.join();
    std::cout << std::endl;
    return 0;
}
