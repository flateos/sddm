/*
* Copyright (c) 2021 Romullo @hiukky.
*
* This file is part of FlateOS
* (see https://github.com/flateos).
*
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU Lesser General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU Lesser General Public License for more details.
*
* You should have received a copy of the GNU Lesser General Public License
* along with this program. If not, see <http://www.gnu.org/licenses/>.
*/

#include <QGuiApplication>
#include <QQmlContext>
#include <QQuickView>

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    QQuickView view;
    view.setSource(QStringLiteral("qrc:/Main.qml"));

    QQmlContext* rootContext = view.rootContext();
    rootContext->setContextProperty("WINDOW_WIDTH", 680);
    rootContext->setContextProperty("WINDOW_HEIGHT", 440);

    view.show();

    return app.exec();
}
