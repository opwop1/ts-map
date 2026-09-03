using System;
using System.Drawing;

namespace TsMap
{
    public class MapPalette
    {
        /// <summary>
        /// Background of map
        /// </summary>
        public Brush Background;

        /// <summary>
        /// Color of Road segments
        /// </summary>
        public Brush Road;

        /// <summary>
        /// Ferry Lines
        /// </summary>
        public Brush FerryLines;

        /// <summary>
        /// Prefab roads (prefabs are crosspoints, etc.)
        /// </summary>
        public Brush PrefabRoad;

        /// <summary>
        /// Prefab polygon light background
        /// </summary>
        public Brush PrefabLight;

        /// <summary>
        /// Prefab polygon dark background
        /// </summary>
        public Brush PrefabDark;

        /// <summary>
        /// Prefab polygon green background (called green in blender, seems to be the same as PrefabLight in in-game map)
        /// </summary>
        public Brush PrefabGreen;

        /// <summary>
        /// City names color
        /// </summary>
        public Brush CityName;

        /// <summary>
        /// Brush for error text
        /// </summary>
        public Brush Error;

        /// <summary>
        /// 设置路线颜色 (导出瓦片用): White = 还原默认配色, 其他颜色 = 单色路线
        /// </summary>
        public void SetRoadColor(Color color)
        {
            if (color == Color.White)
            {
                Road = Brushes.White;
                PrefabRoad = Brushes.White;
                PrefabLight = new SolidBrush(Color.FromArgb(236, 203, 153));
                PrefabDark = new SolidBrush(Color.FromArgb(225, 163, 56));
            }
            else
            {
                var brush = new SolidBrush(color);
                Road = brush;
                PrefabRoad = brush;
                // 立交/路口路面多边形: 与路线同色系, 仅轻微明暗变化(避免看起来发白)
                PrefabLight = new SolidBrush(Color.FromArgb(
                    Math.Min(255, color.R + 10),
                    Math.Min(255, color.G + 8),
                    Math.Max(0, color.B - 10)));
                PrefabDark = new SolidBrush(Color.FromArgb(
                    (int)(color.R * 0.88),
                    (int)(color.G * 0.88),
                    (int)(color.B * 0.88)));
            }
        }
    }
}