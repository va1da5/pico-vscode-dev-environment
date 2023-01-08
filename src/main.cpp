/*
    Simple SOS blink example in C++

*/
#include <vector>
#include "pico/stdlib.h"

using namespace std;

void blink(uint pin, int high_time_ms, int low_time_ms)
{
    gpio_put(pin, 1);
    sleep_ms(high_time_ms);
    gpio_put(pin, 0);
    sleep_ms(low_time_ms);
}

void emit(vector<char> signals, int size, uint pin)
{
    for (char signal : signals)
    {
        switch (signal)
        {
        case '.':
            blink(pin, 100, 50);
            break;
        case '-':
            blink(pin, 400, 150);
            break;
        }
        sleep_ms(300);
    }
}

int main()
{
#ifndef PICO_DEFAULT_LED_PIN
#warning blink example requires a board with a regular LED
#else

    vector<char> sos = {'.', '.', '.', '-', '-', '-', '.', '.', '.'};

    const uint LED_PIN = PICO_DEFAULT_LED_PIN;
    gpio_init(LED_PIN);
    gpio_set_dir(LED_PIN, GPIO_OUT);
    while (true)
    {
        emit(sos, sizeof(sos), LED_PIN);
        sleep_ms(1000);
    }
#endif
}