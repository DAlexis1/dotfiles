#include "raylib.h"
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv) {
  if (argc != 3) {
    printf("Usage: program_window width_screen height_screen");
    exit(0);
  }
  Rectangle power_off_button = {10., 30., 60., 30.};
  Rectangle reboot_button = {80., 30., 60., 30.};
  Rectangle hibernate_button = {150., 30., 60., 30.};
  InitWindow(220, 100, "Power Manager");
  SetWindowPosition(atoi(argv[1]) - 240, atoi(argv[2]) - 140);
  // SetWindowPosition(0, 0);
  SetWindowOpacity(0.7);
  Font fontTTF = LoadFontEx("MononokiNerdFontMono-Regular.ttf", 35, 0, 10000);
  while (!WindowShouldClose()) {
    BeginDrawing();
    ClearBackground(BLACK);
    if (CheckCollisionPointRec(GetMousePosition(), power_off_button)) {
      DrawRectangleRec(power_off_button, WHITE);
    }
    if (CheckCollisionPointRec(GetMousePosition(), reboot_button)) {
      DrawRectangleRec(reboot_button, WHITE);
    }
    if (CheckCollisionPointRec(GetMousePosition(), hibernate_button)) {
      DrawRectangleRec(hibernate_button, WHITE);
    }
    DrawRectangleLinesEx(power_off_button, 2, WHITE);
    DrawRectangleLinesEx(reboot_button, 2, WHITE);
    DrawRectangleLinesEx(hibernate_button, 2, WHITE);
    DrawTextEx(fontTTF, "Power manager", (Vector2){50, 5}, 20, 0.5, RED);
    DrawTextEx(
        fontTTF, "⏼ ",
        (Vector2){(int)power_off_button.x + 25, (int)power_off_button.y + 3},
        30, 2, ORANGE);
    DrawTextEx(fontTTF, "Reboot",
               (Vector2){(int)reboot_button.x + 7, (int)reboot_button.y + 10},
               15, 0, ORANGE);
    DrawTextEx(
        fontTTF, "Quit",
        (Vector2){(int)hibernate_button.x + 15, (int)hibernate_button.y + 10},
        15, 2, ORANGE);
    EndDrawing();

    if (CheckCollisionPointRec(GetMousePosition(), power_off_button) &&
        IsMouseButtonDown(MOUSE_BUTTON_LEFT)) {
      UnloadFont(fontTTF);
      return 1;
      // exit(9000);
    }
    if (CheckCollisionPointRec(GetMousePosition(), reboot_button) &&
        IsMouseButtonDown(MOUSE_BUTTON_LEFT)) {
      UnloadFont(fontTTF);
      return 2;
    }
    if (CheckCollisionPointRec(GetMousePosition(), hibernate_button) &&
        IsMouseButtonDown(MOUSE_BUTTON_LEFT)) {
      UnloadFont(fontTTF);
      return 0;
    }
  }
  return 0;
}
